from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import RoomEntryViewSet

router = DefaultRouter()
router.register(r'entries', RoomEntryViewSet, basename='room-entry')

urlpatterns = [
    path('', include(router.urls)),
]
