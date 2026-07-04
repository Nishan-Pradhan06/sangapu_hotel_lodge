import 'package:flutter/material.dart';

import '../../../core/widgets/custom_padding.dart';
import '../../reports/widgets/earning_cards.dart';
import '../../statements/widgets/transcation_tile.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Semantic amount colors sourced from AppTheme, not hardcoded here.
    final negativeColor = colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses', style: TextTheme.of(context).titleLarge),
      ),
      body: CustomPadding(
        horizontal: 20,
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EarningsCard(
              title: 'Today Expenses',
              amount: 'Rs 500.00',
              backgroundColor: const Color(0xFF7e1a44).withValues(alpha: 0.9),
              subtitle: '-12% from yesterday',
              icon: Icons.show_chart_rounded,
            ),
            EarningsCard(
              title: 'Today Expenses',
              amount: 'Rs 500.00',
              backgroundColor: const Color(0xFF7e1a44).withValues(alpha: 0.9),
              subtitle: '-12% from yesterday',
              icon: Icons.show_chart_rounded,
            ),
            Text('Expenses List', style: TextTheme.of(context).titleMedium),
            Column(
              children: [
                TransactionTile(
                  title: Text(
                    "hell",
                    // "${transaction.category} | ${transaction.remarks}",
                    style: textTheme.titleSmall,
                  ),
                  dateTime: Text(
                    "11111",
                    // transaction.nepaliDate,
                    style: textTheme.bodySmall,
                  ),
                  amount: Text(
                    "dd",
                    // " -${transaction.amount.toString()}",
                    style: textTheme.titleMedium?.copyWith(
                      color: negativeColor,
                    ),
                  ),
                  balance: Text(
                    "Dd",
                    // data.summary.netBalance.toString(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Divider(color: colorScheme.outline, height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Center(
//                 child: Text(
//                   'No expenses recorded yet.',
//                   style: TextTheme.of(context).bodyMedium,
//                 ),
//               ),