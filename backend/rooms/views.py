from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import RoomEntry
from .serializers import RoomEntrySerializer

class RoomEntryViewSet(viewsets.ModelViewSet):
    queryset = RoomEntry.objects.all().order_by('-created_at')
    serializer_class = RoomEntrySerializer
    permission_classes = [IsAuthenticated]
