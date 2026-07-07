from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.pagination import PageNumberPagination
from django.db.models import Count, Sum, Q, DecimalField, F
from django.db.models.functions import Coalesce, Substr
from django.utils import timezone
from rooms.models import RoomEntry


class IncomePagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'per_page'
    max_page_size = 100


class IncomeView(APIView):
    """
    GET /api/income/
    Returns all income grouped by date with summary.

    Summary includes:
      - total_income   : all-time total income
      - daily_income   : income from entries created today (Gregorian date, resets each day)
      - monthly_income : income from the current Nepali month (YYYY-MM prefix)
      - total_records  : total number of RoomEntry records

    Data: paginated list of daily income grouped by nepali_date (newest first).
    Pagination: 10 records per page (override with ?per_page=N)
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        qs = RoomEntry.objects.filter(user=request.user)

        # ── Grouped daily data ───────────────────────────────────────────────
        daily_data = list(
            qs.annotate(date=F('nepali_date'))
            .values('date')
            .annotate(
                total_entries=Count('id'),
                fixed_price_entries=Count('id', filter=Q(fixed_price__isnull=False)),
                custom_price_entries=Count('id', filter=Q(custom_price__isnull=False)),
                total_income=(
                    Sum(Coalesce('fixed_price', 0, output_field=DecimalField())) +
                    Sum(Coalesce('custom_price', 0, output_field=DecimalField()))
                )
            )
            .order_by('-date')
        )

        # Convert Decimal → float for JSON serialisation
        for item in daily_data:
            item['total_income'] = float(item['total_income'] or 0)

        # ── All-time totals ──────────────────────────────────────────────────
        total_income = sum(item['total_income'] for item in daily_data)
        total_records = sum(item['total_entries'] for item in daily_data)

        # ── Daily income: entries created today (Gregorian) ──────────────────
        # Uses created_at so it always resets at midnight regardless of nepali_date value.
        today = timezone.localdate()
        daily_income_agg = qs.filter(created_at__date=today).aggregate(
            total=Sum(
                Coalesce('fixed_price', 0, output_field=DecimalField()) +
                Coalesce('custom_price', 0, output_field=DecimalField())
            )
        )
        daily_income = float(daily_income_agg['total'] or 0)

        # ── Monthly income: current Nepali month prefix (YYYY-MM) ─────────────
        # Derive month prefix from the latest entry's nepali_date.
        # Falls back to 0 if no entries exist.
        latest_entry = qs.order_by('-nepali_date').first()
        monthly_income = 0.0
        if latest_entry:
            month_prefix = latest_entry.nepali_date[:7]  # e.g. "2083-03"
            monthly_agg = qs.filter(nepali_date__startswith=month_prefix).aggregate(
                total=Sum(
                    Coalesce('fixed_price', 0, output_field=DecimalField()) +
                    Coalesce('custom_price', 0, output_field=DecimalField())
                )
            )
            monthly_income = float(monthly_agg['total'] or 0)

        # ── Pagination ───────────────────────────────────────────────────────
        paginator = IncomePagination()
        page = paginator.paginate_queryset(daily_data, request)

        summary = {
            "total_income": float(total_income),
            "daily_income": daily_income,
            "monthly_income": monthly_income,
            "total_records": total_records,
        }

        return Response({
            "summary": summary,
            "pagination": {
                "count": paginator.page.paginator.count,
                "total_pages": paginator.page.paginator.num_pages,
                "current_page": paginator.page.number,
                "per_page": paginator.get_page_size(request),
                "next": paginator.get_next_link(),
                "previous": paginator.get_previous_link(),
            },
            "data": page,
        })
