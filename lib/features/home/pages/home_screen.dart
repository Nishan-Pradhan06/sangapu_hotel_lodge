import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Column(children: [Text('Hello')]),
    );
  }
}
