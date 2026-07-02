from django.urls import path
from .views import StatementView

urlpatterns = [
    path('', StatementView.as_view(), name='statement'),
]
