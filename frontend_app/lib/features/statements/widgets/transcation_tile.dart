// Reusable transaction row widget — accepts pre-built Text widgets
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final Widget title;
  final Widget dateTime;
  final Widget amount;
  final Widget balance;

  const TransactionTile({
    super.key,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [title, const SizedBox(height: 6), dateTime],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [amount, const SizedBox(height: 6), balance],
          ),
        ),
      ],
    );
  }
}
