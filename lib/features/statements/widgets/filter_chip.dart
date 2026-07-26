// Reusable filter chip widget — colors passed in dynamically
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: textTheme.labelLarge?.copyWith(color: textColor)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, color: textColor, size: 18),
        ],
      ),
    );
  }
}
