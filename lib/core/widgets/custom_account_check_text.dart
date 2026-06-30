import 'package:flutter/material.dart';

class AccountCheckText extends StatelessWidget {
  final String message;
  final String actionText;
  final VoidCallback onTap;

  const AccountCheckText({
    super.key,
    required this.message,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            " $actionText",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF6B46C1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
