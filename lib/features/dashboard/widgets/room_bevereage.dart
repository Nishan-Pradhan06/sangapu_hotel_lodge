import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sangapu/features/income/blocs/room_beverage/room_beverage_bloc.dart';

class RoomBeverageSummaryTable extends StatelessWidget {
  const RoomBeverageSummaryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBeverageBloc, RoomBeverageState>(
      builder: (context, state) {
        return state.when(
          initial: () => const _TableShimmer(),
          loading: () => const _TableShimmer(),
          failure: (failure) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Failed to load summary: ${failure.message}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
          loaded: (data) {
            // Helper to format values consistently (e.g., 29500 -> "29,500.00" or raw string)
            String formatAmount(num value) => value.toStringAsFixed(2);

            final roomIncome = data.roomTotalIncome;
            final roomExpenses = data.roomTotalExpenses;
            final roomNet = roomIncome - roomExpenses;

            final beverageIncome = data.beverageTotalIncome;
            final beverageExpenses = data.beverageTotalExpenses;
            final beverageNet = beverageIncome - beverageExpenses;

            return FinancialSummaryTable(
              rows: [
                SummaryRow(
                  snNo: 1,
                  source: 'Room Income',
                  total: formatAmount(roomIncome),
                  type: SummaryRowType.income,
                ),
                SummaryRow(
                  snNo: 2,
                  source: 'Room Expenses',
                  total: formatAmount(roomExpenses),
                  type: SummaryRowType.expense,
                ),
                SummaryRow(
                  source: 'NET TOTAL (ROOM)',
                  total: formatAmount(roomNet),
                  type: SummaryRowType.netTotal,
                ),
                SummaryRow(
                  snNo: 3,
                  source: 'Beverage Income',
                  total: formatAmount(beverageIncome),
                  type: SummaryRowType.income,
                ),
                SummaryRow(
                  snNo: 4,
                  source: 'Beverage Expenses',
                  total: formatAmount(beverageExpenses),
                  type: SummaryRowType.expense,
                ),
                SummaryRow(
                  source: 'NET TOTAL (BEVERAGE)',
                  total: formatAmount(beverageNet),
                  type: SummaryRowType.netTotal,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _TableShimmer extends StatelessWidget {
  const _TableShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 410,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: List.generate(
            7, // Header + 6 rows
            (index) => Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: index == 6 ? 0 : 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Model for a single row in the summary table.
class SummaryRow {
  final int? snNo;
  final String source;
  final String total; 
  final SummaryRowType type;

  const SummaryRow({
    this.snNo,
    required this.source,
    required this.total,
    required this.type,
  });
}

enum SummaryRowType { income, expense, netTotal }

class FinancialSummaryTable extends StatelessWidget {
  final String? title;
  final List<SummaryRow> rows;

  /// Fixed column widths in logical pixels. Because the table scrolls
  /// horizontally, columns cannot use Expanded/flex — they need a
  /// concrete width so the Row has a bounded, known total width.
  final double snColumnWidth;
  final double sourceColumnWidth;
  final double totalColumnWidth;

  const FinancialSummaryTable({
    super.key,
    this.title,
    required this.rows,
    this.snColumnWidth = 60,
    this.sourceColumnWidth = 220,
    this.totalColumnWidth = 130,
  });

  // ---- Theme colors (tweak these to match your app theme) ----
  static const _headerColor = Color(0xFF1B3A5C);
  static const _incomeBg = Color(0xFFDDF5E6);
  static const _incomeText = Color(0xFF1E7A46);
  static const _expenseBg = Color(0xFFFBE3E3);
  static const _expenseText = Color(0xFFB0281F);
  static const _netBg = Color(0xFFFCE68C);
  static const _netBorder = Color(0xFFB98A0A);
  static const _netTextDark = Color(0xFF2E2E2E);
  static const _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    // Outer scroll view lets the table exceed the screen width and be
    // swiped left/right, instead of overflowing or being squeezed.
    // No explicit width here: the Rows below use fixed-width SizedBox
    // children, so the Container's intrinsic width is already exactly
    // right. Forcing width: _totalWidth would conflict with the 1px
    // border inset (Container insets its child by the border width),
    // causing a 2px overflow.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) _buildHeaderTitle(title!),
            _buildColumnHeader(),
            ...rows.map(_buildRow),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTitle(String text) {
    return Container(
      width: double.infinity,
      color: _headerColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildColumnHeader() {
    return Container(
      color: _headerColor,
      child: Row(
        children: [
          _HeaderCell('SN No', width: snColumnWidth),
          _HeaderCell('Source', width: sourceColumnWidth),
          _HeaderCell(
            'Total',
            width: totalColumnWidth,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(SummaryRow row) {
    switch (row.type) {
      case SummaryRowType.income:
        return _dataRow(row, bg: _incomeBg, textColor: _incomeText);
      case SummaryRowType.expense:
        return _dataRow(row, bg: _expenseBg, textColor: _expenseText);
      case SummaryRowType.netTotal:
        return _netTotalRow(row);
    }
  }

  Widget _dataRow(
    SummaryRow row, {
    required Color bg,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: const Border(bottom: BorderSide(color: _borderColor, width: 1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: snColumnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${row.snNo ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor.withOpacity(0.6)),
              ),
            ),
          ),
          SizedBox(
            width: sourceColumnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                row.source,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            width: totalColumnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                row.total,
                textAlign: TextAlign.left,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _netTotalRow(SummaryRow row) {
    final isNegative = row.total.trim().startsWith('-');
    return Container(
      decoration: BoxDecoration(
        color: _netBg,
        border: const Border(
          top: BorderSide(color: _netBorder, width: 1),
          bottom: BorderSide(color: _netBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: snColumnWidth),
          SizedBox(
            width: sourceColumnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                row.source,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: totalColumnWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                row.total,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: isNegative ? _expenseText : _netTextDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final double width;
  final Alignment alignment;

  const _HeaderCell(
    this.text, {
    required this.width,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Align(
          alignment: alignment,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
