import 'package:flutter/material.dart';
import 'package:sangapu/core/widgets/custom_container.dart';

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
      body: Column(
        children: [
          CustomContainer(child: Column())
        ],
      ),
    );
  }
}
