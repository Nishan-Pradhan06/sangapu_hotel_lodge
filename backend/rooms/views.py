from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import RoomEntry
from .serializers import RoomEntrySerializer

class RoomEntryViewSet(viewsets.ModelViewSet):
    serializer_class = RoomEntrySerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return RoomEntry.objects.filter(user=self.request.user).order_by('-created_at')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
