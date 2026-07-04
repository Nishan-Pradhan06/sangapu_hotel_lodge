import 'package:flutter/material.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expenses')),
      body: const Center(child: Text('Add Expenses Page')),
    );
  }
}
