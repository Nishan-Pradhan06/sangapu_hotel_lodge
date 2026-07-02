from django.urls import path
from .views import StatementView, StatementExcelExportView, StatementPDFExportView

urlpatterns = [
    path('', StatementView.as_view(), name='statement'),
    path('export/excel/', StatementExcelExportView.as_view(), name='statement-export-excel'),
    path('export/pdf/', StatementPDFExportView.as_view(), name='statement-export-pdf'),
]
