from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.db.models import Sum
from django.utils import timezone
from .models import ExpenseEntry
from .serializers import ExpenseEntrySerializer


class ExpenseEntryViewSet(viewsets.ModelViewSet):
    serializer_class = ExpenseEntrySerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return ExpenseEntry.objects.filter(user=self.request.user).order_by('-created_at')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        # ── Daily expenses: entries created today (Gregorian midnight reset) ──
        today = timezone.localdate()
        total_daily_expenses = (
            queryset.filter(created_at__date=today)
            .aggregate(Sum('amount'))['amount__sum'] or 0
        )

        # ── Monthly expenses: current Nepali month from latest entry ──────────
        total_monthly_expenses = 0
        latest_entry = queryset.first()
        if latest_entry:
            current_month = latest_entry.nepali_date[:7]   # e.g. "2083-03"
            total_monthly_expenses = (
                queryset.filter(nepali_date__startswith=current_month)
                .aggregate(Sum('amount'))['amount__sum'] or 0
            )

        serializer = self.get_serializer(queryset, many=True)
        return Response({
            "summary": {
                "total_daily_expenses":   float(total_daily_expenses),
                "total_monthly_expenses": float(total_monthly_expenses),
                "total_records":          queryset.count(),
            },
            "data": serializer.data,
        })
