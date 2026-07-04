import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../routers/app_routes_names.dart';
import '../../reports/widgets/earning_cards.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SHANGAPU HOTEL & LODGE',
              style: TextTheme.of(context).titleLarge,
            ),
            Text(
              DateHelper.nepaliDate(),
              style: TextTheme.of(context).bodySmall,
            ),
          ],
        ),
      ),
      body: CustomPadding(
        child: Column(
          spacing: 20,
          children: [
            EarningsCard(
              title: 'Today Earnings',
              amount: 'Rs 5,600.00',
              backgroundColor: const Color(0xFF1A237E).withValues(alpha: 0.9),
              subtitle: '+12% from yesterday',
              icon: Icons.show_chart_rounded,
            ),

            EarningsCard(
              title: 'Total Sales',
              amount: 'Rs 25,600.00',
              backgroundColor: const Color(0xFFFF9800).withValues(alpha: 0.8),
              icon: Icons.calendar_month_rounded,
              subtitle: 'On Track for target',
            ),
            EarningsCard(
              title: 'Today Expenses',
              amount: 'Rs 500.00',
              backgroundColor: const Color(0xFF7e1a44).withValues(alpha: 0.9),
              subtitle: '-12% from yesterday',
              icon: Icons.show_chart_rounded,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'bottom_nav_fab',
        onPressed: () {
          context.pushNamed(AppRoutesName.createRoomEntryPage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
