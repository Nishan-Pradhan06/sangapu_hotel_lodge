import 'package:flutter/material.dart';

import '../../../core/widgets/custom_container.dart';

class EarningsCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color backgroundColor;
  final String? subtitle;
  final IconData? icon;

  const EarningsCard({
    super.key,
    required this.title,
    required this.amount,
    required this.backgroundColor,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      useIntrinsicHeight: true,
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            title,
            style: TextTheme.of(
              context,
            ).titleSmall?.copyWith(color: Colors.white),
          ),

          Text(
            amount,
            style: TextTheme.of(
              context,
            ).headlineMedium?.copyWith(color: Colors.white),
          ),

          if (subtitle != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, color: Colors.white, size: 18),

                if (icon != null) const SizedBox(width: 5),

                Text(
                  subtitle!,
                  style: TextTheme.of(
                    context,
                  ).titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
