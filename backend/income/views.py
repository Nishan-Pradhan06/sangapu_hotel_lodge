from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.db.models import Count, Sum, Q, DecimalField
from django.db.models.functions import Coalesce, Substr
from rooms.models import RoomEntry

class DailyIncomeView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        data = RoomEntry.objects.values('nepali_date').annotate(
            total_entries=Count('id'),
            fixed_price_entries=Count('id', filter=Q(fixed_price__isnull=False)),
            custom_price_entries=Count('id', filter=Q(custom_price__isnull=False)),
            total_income=Sum(Coalesce('fixed_price', 0, output_field=DecimalField())) + 
                         Sum(Coalesce('custom_price', 0, output_field=DecimalField()))
        ).order_by('-nepali_date')
        
        return Response(data)

class MonthlyIncomeView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        data = RoomEntry.objects.annotate(
            month=Substr('nepali_date', 1, 7)
        ).values('month').annotate(
            total_entries=Count('id'),
            fixed_price_entries=Count('id', filter=Q(fixed_price__isnull=False)),
            custom_price_entries=Count('id', filter=Q(custom_price__isnull=False)),
            total_income=Sum(Coalesce('fixed_price', 0, output_field=DecimalField())) + 
                         Sum(Coalesce('custom_price', 0, output_field=DecimalField()))
        ).order_by('-month')
        
        return Response(data)
