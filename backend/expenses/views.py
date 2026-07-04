from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.db.models import Sum
from .models import ExpenseEntry
from .serializers import ExpenseEntrySerializer


class ExpenseEntryViewSet(viewsets.ModelViewSet):
    queryset = ExpenseEntry.objects.all().order_by('-created_at')
    serializer_class = ExpenseEntrySerializer
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        
        latest_entry = queryset.first()
        total_daily_expenses = 0
        total_monthly_expenses = 0
        
        if latest_entry:
            current_date = latest_entry.nepali_date
            current_month = current_date[:7]
            
            total_daily_expenses = queryset.filter(nepali_date=current_date).aggregate(Sum('amount'))['amount__sum'] or 0
            total_monthly_expenses = queryset.filter(nepali_date__startswith=current_month).aggregate(Sum('amount'))['amount__sum'] or 0

        serializer = self.get_serializer(queryset, many=True)
        return Response({
            "summary": {
                "total_daily_expenses": float(total_daily_expenses),
                "total_monthly_expenses": float(total_monthly_expenses),
                "total_records": queryset.count(),
            },
            "data": serializer.data
        })
