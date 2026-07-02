import io
from decimal import Decimal

from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from rooms.models import RoomEntry
from expenses.models import ExpenseEntry


# ─────────────────────────────────────────────
#  Shared helper: build + filter records
# ─────────────────────────────────────────────
def _build_income_records(entries):
    records = []
    for entry in entries:
        price = entry.fixed_price if entry.fixed_price is not None else entry.custom_price
        records.append({
            'id': entry.id,
            'type': 'Income',
            'category': 'Fixed Price' if entry.fixed_price is not None else 'Custom Price',
            'amount': float(price),
            'remarks': entry.additional_notes or '',
            'nepali_date': entry.nepali_date,
            'created_at': entry.created_at,
        })
    return records


def _build_expense_records(entries):
    records = []
    for entry in entries:
        records.append({
            'id': entry.id,
            'type': 'Expense',
            'category': entry.get_category_display(),
            'amount': float(entry.amount),
            'remarks': entry.remarks or '',
            'nepali_date': entry.nepali_date,
            'created_at': entry.created_at,
        })
    return records


def get_filtered_records(request):
    """Apply query params and return (records, total_income, total_expenses)."""
    filter_type  = request.query_params.get('type', 'all')
    filter_date  = request.query_params.get('date', None)
    filter_month = request.query_params.get('month', None)
    ordering     = request.query_params.get('ordering', 'desc')

    income_qs  = RoomEntry.objects.all()
    expense_qs = ExpenseEntry.objects.all()

    if filter_date:
        income_qs  = income_qs.filter(nepali_date=filter_date)
        expense_qs = expense_qs.filter(nepali_date=filter_date)
    if filter_month:
        income_qs  = income_qs.filter(nepali_date__startswith=filter_month)
        expense_qs = expense_qs.filter(nepali_date__startswith=filter_month)

    records        = []
    total_income   = Decimal('0')
    total_expenses = Decimal('0')

    if filter_type in ('income', 'all'):
        inc = _build_income_records(income_qs)
        records.extend(inc)
        for r in inc:
            total_income += Decimal(str(r['amount']))

    if filter_type in ('expenses', 'all'):
        exp = _build_expense_records(expense_qs)
        records.extend(exp)
        for r in exp:
            total_expenses += Decimal(str(r['amount']))

    reverse = (ordering == 'desc')
    records.sort(key=lambda x: (x['nepali_date'], str(x['created_at'])), reverse=reverse)

    return records, total_income, total_expenses


# ─────────────────────────────────────────────
#  JSON Statement
# ─────────────────────────────────────────────
class StatementView(APIView):
    """
    Bank-style statement combining all income and expenses.

    Query Params: type, date, month, ordering
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        records, total_income, total_expenses = get_filtered_records(request)
        net_balance = total_income - total_expenses

        return Response({
            'summary': {
                'total_income':   float(total_income),
                'total_expenses': float(total_expenses),
                'net_balance':    float(net_balance),
                'total_records':  len(records),
            },
            'transactions': records,
        })


# ─────────────────────────────────────────────
#  Excel Export
# ─────────────────────────────────────────────
class StatementExcelExportView(APIView):
    """
    Export statement as Excel (.xlsx).

    Query Params: type, date, month, ordering
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        from openpyxl import Workbook
        from openpyxl.styles import (
            Font, PatternFill, Alignment, Border, Side
        )
        from openpyxl.utils import get_column_letter

        records, total_income, total_expenses = get_filtered_records(request)
        net_balance = total_income - total_expenses

        wb = Workbook()
        ws = wb.active
        ws.title = "Statement"

        # ── colour palette ──────────────────────────────
        HEADER_FILL   = PatternFill("solid", fgColor="1F4E79")
        INCOME_FILL   = PatternFill("solid", fgColor="E8F5E9")
        EXPENSE_FILL  = PatternFill("solid", fgColor="FFEBEE")
        SUMMARY_FILL  = PatternFill("solid", fgColor="FFF9C4")
        TITLE_FILL    = PatternFill("solid", fgColor="2E75B6")

        thin = Side(style='thin', color="BDBDBD")
        border = Border(left=thin, right=thin, top=thin, bottom=thin)

        # ── Title ───────────────────────────────────────
        ws.merge_cells("A1:G1")
        title_cell = ws["A1"]
        title_cell.value = "Hotel Lodge — Statement Report"
        title_cell.font = Font(name="Calibri", size=16, bold=True, color="FFFFFF")
        title_cell.fill = TITLE_FILL
        title_cell.alignment = Alignment(horizontal="center", vertical="center")
        ws.row_dimensions[1].height = 32

        ws.append([])  # blank row

        # ── Summary block ───────────────────────────────
        summary_rows = [
            ("Total Income",   float(total_income)),
            ("Total Expenses", float(total_expenses)),
            ("Net Balance",    float(net_balance)),
        ]
        for label, value in summary_rows:
            row_idx = ws.max_row + 1
            ws.cell(row=row_idx, column=1, value=label).font = Font(bold=True)
            cell = ws.cell(row=row_idx, column=2, value=value)
            cell.number_format = '#,##0.00'
            cell.fill = SUMMARY_FILL
            if label == "Net Balance":
                cell.font = Font(bold=True, color="1B5E20" if value >= 0 else "B71C1C")

        ws.append([])  # blank row

        # ── Column headers ──────────────────────────────
        headers = ["#", "Date (BS)", "Type", "Category", "Amount (Rs.)", "Remarks", "Recorded At"]
        header_row = ws.max_row + 1
        for col, h in enumerate(headers, start=1):
            cell = ws.cell(row=header_row, column=col, value=h)
            cell.font      = Font(name="Calibri", bold=True, color="FFFFFF", size=11)
            cell.fill      = HEADER_FILL
            cell.alignment = Alignment(horizontal="center")
            cell.border    = border

        # ── Data rows ───────────────────────────────────
        for idx, r in enumerate(records, start=1):
            row_idx = ws.max_row + 1
            fill = INCOME_FILL if r['type'] == 'Income' else EXPENSE_FILL

            values = [
                idx,
                r['nepali_date'],
                r['type'],
                r['category'],
                r['amount'],
                r['remarks'],
                str(r['created_at'])[:19],
            ]
            for col, val in enumerate(values, start=1):
                cell = ws.cell(row=row_idx, column=col, value=val)
                cell.fill   = fill
                cell.border = border
                cell.alignment = Alignment(vertical="center")
                if col == 5:  # amount
                    cell.number_format = '#,##0.00'

        # ── Column widths ───────────────────────────────
        col_widths = [5, 14, 10, 18, 15, 35, 22]
        for i, w in enumerate(col_widths, start=1):
            ws.column_dimensions[get_column_letter(i)].width = w

        # ── Stream response ─────────────────────────────
        buffer = io.BytesIO()
        wb.save(buffer)
        buffer.seek(0)

        response = HttpResponse(
            buffer,
            content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        )
        response["Content-Disposition"] = 'attachment; filename="statement.xlsx"'
        return response


# ─────────────────────────────────────────────
#  PDF Export
# ─────────────────────────────────────────────
class StatementPDFExportView(APIView):
    """
    Export statement as PDF.

    Query Params: type, date, month, ordering
    """
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        from reportlab.lib.pagesizes import A4, landscape
        from reportlab.lib import colors
        from reportlab.lib.units import mm
        from reportlab.platypus import (
            SimpleDocTemplate, Table, TableStyle, Paragraph,
            Spacer, HRFlowable
        )
        from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
        from reportlab.lib.enums import TA_CENTER, TA_RIGHT

        records, total_income, total_expenses = get_filtered_records(request)
        net_balance = total_income - total_expenses

        buffer = io.BytesIO()
        doc = SimpleDocTemplate(
            buffer,
            pagesize=landscape(A4),
            rightMargin=15*mm, leftMargin=15*mm,
            topMargin=15*mm,   bottomMargin=15*mm,
        )

        styles = getSampleStyleSheet()
        PAGE_W = landscape(A4)[0] - 30*mm

        # ── Custom styles ────────────────────────────────
        title_style = ParagraphStyle(
            'Title', parent=styles['Title'],
            fontSize=18, textColor=colors.HexColor('#1F4E79'),
            spaceAfter=6, alignment=TA_CENTER,
        )
        sub_style = ParagraphStyle(
            'Sub', parent=styles['Normal'],
            fontSize=10, textColor=colors.grey,
            spaceAfter=12, alignment=TA_CENTER,
        )
        label_style = ParagraphStyle(
            'Label', parent=styles['Normal'],
            fontSize=10, textColor=colors.HexColor('#333333'),
        )

        story = []

        # ── Title ────────────────────────────────────────
        story.append(Paragraph("Hotel Lodge — Statement Report", title_style))
        story.append(Paragraph("Generated automatically", sub_style))
        story.append(HRFlowable(width=PAGE_W, color=colors.HexColor('#2E75B6'), thickness=2))
        story.append(Spacer(1, 8*mm))

        # ── Summary table ────────────────────────────────
        summary_data = [
            ["Total Income",   f"Rs. {float(total_income):,.2f}"],
            ["Total Expenses", f"Rs. {float(total_expenses):,.2f}"],
            ["Net Balance",    f"Rs. {float(net_balance):,.2f}"],
        ]
        sum_table = Table(summary_data, colWidths=[80*mm, 60*mm])
        sum_table.setStyle(TableStyle([
            ('FONTNAME',    (0, 0), (-1, -1), 'Helvetica'),
            ('FONTSIZE',    (0, 0), (-1, -1), 10),
            ('FONTNAME',    (0, 0), (0, -1), 'Helvetica-Bold'),
            ('BACKGROUND',  (0, 0), (-1, -1), colors.HexColor('#FFF9C4')),
            ('BACKGROUND',  (0, 2), (-1, 2), colors.HexColor('#E3F2FD')),
            ('TEXTCOLOR',   (1, 2), (1, 2),
             colors.HexColor('#1B5E20') if net_balance >= 0 else colors.HexColor('#B71C1C')),
            ('FONTNAME',    (0, 2), (-1, 2), 'Helvetica-Bold'),
            ('ALIGN',       (1, 0), (1, -1), 'RIGHT'),
            ('ROWBACKGROUND', (0, 0), (-1, -1), [colors.HexColor('#FFF9C4'), colors.HexColor('#FFFDE7')]),
            ('BOX',         (0, 0), (-1, -1), 0.5, colors.grey),
            ('INNERGRID',   (0, 0), (-1, -1), 0.5, colors.lightgrey),
            ('TOPPADDING',  (0, 0), (-1, -1), 5),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 5),
        ]))
        story.append(sum_table)
        story.append(Spacer(1, 8*mm))

        # ── Transactions table ───────────────────────────
        col_headers = ["#", "Date (BS)", "Type", "Category", "Amount (Rs.)", "Remarks"]
        table_data = [col_headers]

        INCOME_BG  = colors.HexColor('#E8F5E9')
        EXPENSE_BG = colors.HexColor('#FFEBEE')
        row_colors = []

        for idx, r in enumerate(records, start=1):
            table_data.append([
                str(idx),
                r['nepali_date'],
                r['type'],
                r['category'],
                f"{r['amount']:,.2f}",
                r['remarks'][:60] + ('…' if len(r['remarks']) > 60 else ''),
            ])
            row_colors.append(INCOME_BG if r['type'] == 'Income' else EXPENSE_BG)

        col_widths = [12*mm, 28*mm, 22*mm, 40*mm, 30*mm, None]
        tx_table = Table(table_data, colWidths=col_widths, repeatRows=1)

        style_cmds = [
            # header
            ('BACKGROUND',   (0, 0), (-1, 0), colors.HexColor('#1F4E79')),
            ('TEXTCOLOR',    (0, 0), (-1, 0), colors.white),
            ('FONTNAME',     (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('FONTSIZE',     (0, 0), (-1, 0), 9),
            ('ALIGN',        (0, 0), (-1, 0), 'CENTER'),
            # data
            ('FONTNAME',     (0, 1), (-1, -1), 'Helvetica'),
            ('FONTSIZE',     (0, 1), (-1, -1), 8),
            ('ALIGN',        (4, 1), (4, -1), 'RIGHT'),
            ('ALIGN',        (0, 1), (0, -1), 'CENTER'),
            # grid
            ('BOX',          (0, 0), (-1, -1), 0.5, colors.grey),
            ('INNERGRID',    (0, 0), (-1, -1), 0.3, colors.lightgrey),
            ('TOPPADDING',   (0, 0), (-1, -1), 4),
            ('BOTTOMPADDING',(0, 0), (-1, -1), 4),
            ('LEFTPADDING',  (0, 0), (-1, -1), 5),
        ]
        # per-row colours
        for i, bg in enumerate(row_colors, start=1):
            style_cmds.append(('BACKGROUND', (0, i), (-1, i), bg))

        tx_table.setStyle(TableStyle(style_cmds))
        story.append(tx_table)

        doc.build(story)
        buffer.seek(0)

        response = HttpResponse(buffer, content_type="application/pdf")
        response["Content-Disposition"] = 'attachment; filename="statement.pdf"'
        return response
