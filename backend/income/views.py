from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.pagination import PageNumberPagination
from django.db.models import Sum, DecimalField
from django.db.models.functions import Coalesce
from django.utils import timezone
from rooms.models import RoomEntry


class IncomePagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'per_page'
    max_page_size = 100


def _serialize_entry(entry):
    """Serialize a single RoomEntry into a flat income record."""
    is_fixed   = entry.fixed_price is not None
    amount     = entry.fixed_price if is_fixed else entry.custom_price
    category   = 'Fixed Price' if is_fixed else 'Custom Price'
    return {
        'id':          entry.id,
        'category':    category,
        'amount':      float(amount) if amount is not None else 0.0,
        'remarks':     entry.additional_notes or '',
        'nepali_date': entry.nepali_date,
        'created_at':  entry.created_at,
        'updated_at':  entry.updated_at,
        'user':        entry.user_id,
    }


class IncomeView(APIView):
    """
    GET /api/income/
    Returns individual income records (flat, like expenses) with summary.

    Summary:
      - total_income   : all-time total income
      - daily_income   : today's income (resets at midnight)
      - monthly_income : current Nepali month income
      - total_records  : total number of RoomEntry records

    Data: paginated list of individual RoomEntry records (newest first).
    Pagination: 10 per page  (override with ?per_page=N)
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        qs = RoomEntry.objects.filter(user=request.user).order_by('-nepali_date', '-created_at')

        # ── Summary aggregates ────────────────────────────────────────────
        def _income_sum(queryset):
            agg = queryset.aggregate(
                total=Sum(
                    Coalesce('fixed_price', 0, output_field=DecimalField()) +
                    Coalesce('custom_price', 0, output_field=DecimalField())
                )
            )
            return float(agg['total'] or 0)

        total_income  = _income_sum(qs)
        total_records = qs.count()

        # Daily income — resets every midnight (uses Gregorian created_at date)
        today         = timezone.localdate()
        daily_income  = _income_sum(qs.filter(created_at__date=today))

        # Monthly income — current Nepali month prefix from latest entry
        monthly_income = 0.0
        latest = qs.first()
        if latest:
            month_prefix   = latest.nepali_date[:7]   # e.g. "2083-03"
            monthly_income = _income_sum(qs.filter(nepali_date__startswith=month_prefix))

        # ── Serialise all entries then paginate ───────────────────────────
        flat_records = [_serialize_entry(e) for e in qs]

        paginator = IncomePagination()
        page      = paginator.paginate_queryset(flat_records, request)

        return Response({
            "summary": {
                "total_income":   total_income,
                "daily_income":   daily_income,
                "monthly_income": monthly_income,
                "total_records":  total_records,
            },
            "pagination": {
                "count":        paginator.page.paginator.count,
                "total_pages":  paginator.page.paginator.num_pages,
                "current_page": paginator.page.number,
                "per_page":     paginator.get_page_size(request),
                "next":         paginator.get_next_link(),
                "previous":     paginator.get_previous_link(),
            },
            "data": page,
        })
