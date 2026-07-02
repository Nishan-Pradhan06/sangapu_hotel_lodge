from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.db.models import Sum, DecimalField
from django.db.models.functions import Coalesce
from rooms.models import RoomEntry
from expenses.models import ExpenseEntry
from decimal import Decimal


class StatementView(APIView):
    """
    Bank-style statement combining all income (room entries) and expenses.

    Query Parameters:
        - type     : 'income' | 'expenses' | 'all'  (default: 'all')
        - date     : exact Nepali date  e.g. '2080-03-15'
        - month    : Nepali year-month  e.g. '2080-03'
        - ordering : 'asc' | 'desc'    (default: 'desc')
    """

    permission_classes = [IsAuthenticated]

    # ------------------------------------------------------------------ #
    #  helpers
    # ------------------------------------------------------------------ #
    def _build_income_records(self, entries):
        records = []
        for entry in entries:
            price = entry.fixed_price if entry.fixed_price is not None else entry.custom_price
            records.append({
                'id': entry.id,
                'type': 'income',
                'category': 'fixed_price' if entry.fixed_price is not None else 'custom_price',
                'amount': float(price),
                'remarks': entry.additional_notes,
                'nepali_date': entry.nepali_date,
                'created_at': entry.created_at,
            })
        return records

    def _build_expense_records(self, entries):
        records = []
        for entry in entries:
            records.append({
                'id': entry.id,
                'type': 'expenses',
                'category': entry.category,
                'category_display': entry.get_category_display(),
                'amount': float(entry.amount),
                'remarks': entry.remarks,
                'nepali_date': entry.nepali_date,
                'created_at': entry.created_at,
            })
        return records

    # ------------------------------------------------------------------ #
    #  GET
    # ------------------------------------------------------------------ #
    def get(self, request, *args, **kwargs):
        filter_type = request.query_params.get('type', 'all')
        filter_date = request.query_params.get('date', None)
        filter_month = request.query_params.get('month', None)
        ordering = request.query_params.get('ordering', 'desc')

        # ---- fetch room entries (income) ----
        income_qs = RoomEntry.objects.all()
        if filter_date:
            income_qs = income_qs.filter(nepali_date=filter_date)
        if filter_month:
            income_qs = income_qs.filter(nepali_date__startswith=filter_month)

        # ---- fetch expense entries ----
        expense_qs = ExpenseEntry.objects.all()
        if filter_date:
            expense_qs = expense_qs.filter(nepali_date=filter_date)
        if filter_month:
            expense_qs = expense_qs.filter(nepali_date__startswith=filter_month)

        # ---- build combined records ----
        records = []
        total_income = Decimal('0')
        total_expenses = Decimal('0')

        if filter_type in ('income', 'all'):
            income_records = self._build_income_records(income_qs)
            records.extend(income_records)
            for r in income_records:
                total_income += Decimal(str(r['amount']))

        if filter_type in ('expenses', 'all'):
            expense_records = self._build_expense_records(expense_qs)
            records.extend(expense_records)
            for r in expense_records:
                total_expenses += Decimal(str(r['amount']))

        # ---- sort by nepali_date ----
        reverse = (ordering == 'desc')
        records.sort(key=lambda x: (x['nepali_date'], str(x['created_at'])), reverse=reverse)

        net_balance = total_income - total_expenses

        return Response({
            'summary': {
                'total_income': float(total_income),
                'total_expenses': float(total_expenses),
                'net_balance': float(net_balance),
                'total_records': len(records),
            },
            'transactions': records,
        })
