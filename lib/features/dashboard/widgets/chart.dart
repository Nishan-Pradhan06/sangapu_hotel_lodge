// Requires the fl_chart package. Add to pubspec.yaml:
//   dependencies:
//     fl_chart: ^0.69.0   // check pub.dev for the current version
//
// Then: flutter pub get

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// One category's income/expense pair, e.g. Room, Beverage.
class CategoryFinance {
  final String label;
  final double income;
  final double expense;

  const CategoryFinance({
    required this.label,
    required this.income,
    required this.expense,
  });

  double get net => income - expense;
}

class BankingSummaryChart extends StatelessWidget {
  final List<CategoryFinance> categories;

  const BankingSummaryChart({super.key, required this.categories});

  static const _incomeColor = Color(0xFF1E7A46);
  static const _expenseColor = Color(0xFFB0281F);
  static const _cardColor = Color(0xFFF7F8FA);
  static const _labelColor = Color(0xFF6B7280);

  double get _totalIncome => categories.fold(0, (sum, c) => sum + c.income);
  double get _totalExpense => categories.fold(0, (sum, c) => sum + c.expense);
  double get _netTotal => _totalIncome - _totalExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryHeader(),
          const SizedBox(height: 20),
          _buildDonut(),
          const SizedBox(height: 24),
          const Text(
            'By category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          _buildBarChart(),
          const SizedBox(height: 12),
          _buildLegend(),
        ],
      ),
    );
  }

  // ---- Top summary row: Income / Expense / Net, banking-dashboard style ----
  Widget _buildSummaryHeader() {
    return Row(
      children: [
        Expanded(child: _summaryTile('Income', _totalIncome, _incomeColor)),
        Container(width: 1, height: 40, color: Colors.grey.shade300),
        Expanded(child: _summaryTile('Expenses', _totalExpense, _expenseColor)),
        Container(width: 1, height: 40, color: Colors.grey.shade300),
        Expanded(
          child: _summaryTile(
            'Net',
            _netTotal,
            _netTotal < 0 ? _expenseColor : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _summaryTile(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: _labelColor)),
        const SizedBox(height: 4),
        Text(
          '${value < 0 ? '-' : ''}${value.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // ---- Donut chart: overall income vs expense share ----
  Widget _buildDonut() {
    final total = _totalIncome + _totalExpense;
    if (total == 0) return const SizedBox.shrink();

    return SizedBox(
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 3,
                centerSpaceRadius: 45,
                sections: [
                  PieChartSectionData(
                    value: _totalIncome,
                    color: _incomeColor,
                    radius: 28,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: _totalExpense,
                    color: _expenseColor,
                    radius: 28,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _donutLegendRow('Income', _incomeColor, _totalIncome, total),
                const SizedBox(height: 10),
                _donutLegendRow(
                  'Expenses',
                  _expenseColor,
                  _totalExpense,
                  total,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _donutLegendRow(
    String label,
    Color color,
    double value,
    double total,
  ) {
    final pct = total == 0 ? 0 : (value / total * 100);
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label  ${pct.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // ---- Grouped bar chart: income vs expense per category ----
  Widget _buildBarChart() {
    final maxVal = categories
        .expand((c) => [c.income, c.expense])
        .fold<double>(0, (m, v) => v > m ? v : m);
    final chartMax = maxVal == 0 ? 1.0 : maxVal * 1.25;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: chartMax,
          alignment: BarChartAlignment.spaceAround,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= categories.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      categories[i].label,
                      style: const TextStyle(fontSize: 12, color: _labelColor),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < categories.length; i++)
              BarChartGroupData(
                x: i,
                barsSpace: 6,
                barRods: [
                  BarChartRodData(
                    toY: categories[i].income,
                    color: _incomeColor,
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  BarChartRodData(
                    toY: categories[i].expense,
                    color: _expenseColor,
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: const [
        _LegendDot(color: _incomeColor, label: 'Income'),
        SizedBox(width: 16),
        _LegendDot(color: _expenseColor, label: 'Expense'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

// ---------------------------------------------------------------
// Example usage (matches your Room / Beverage data)
// ---------------------------------------------------------------
class BankingSummaryChartDemo extends StatelessWidget {
  const BankingSummaryChartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const BankingSummaryChart(
      categories: [
        CategoryFinance(label: 'Room', income: 3000, expense: 588),
        CategoryFinance(label: 'Beverage', income: 1300, expense: 1488),
      ],
    );
  }
}
