import 'package:flutter/material.dart';

import '../../../core/widgets/custom_padding.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses', style: TextTheme.of(context).titleLarge),
      ),
      body: CustomPadding(
        horizontal: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
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