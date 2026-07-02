from django.urls import path
from .views import DailyIncomeView, MonthlyIncomeView

urlpatterns = [
    path('daily/', DailyIncomeView.as_view(), name='daily-income'),
    path('monthly/', MonthlyIncomeView.as_view(), name='monthly-income'),
]
