from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import ExpenseEntry
from .serializers import ExpenseEntrySerializer


class ExpenseEntryViewSet(viewsets.ModelViewSet):
    queryset = ExpenseEntry.objects.all().order_by('-created_at')
    serializer_class = ExpenseEntrySerializer
    permission_classes = [IsAuthenticated]
