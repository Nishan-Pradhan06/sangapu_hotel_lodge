import 'package:flutter/material.dart';
import '../../../core/widgets/custom_padding.dart';
import '../widgets/earning_cards.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/routers/app_routes_names.dart';

class ReportOverviewPage extends StatelessWidget {
  const ReportOverviewPage({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SHANGAPU HOTEL & LODGE'),
            Text('Monday, June 29, 2016', style: TextStyle(fontSize: 16)),
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
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutesName.createRoomEntryPage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
