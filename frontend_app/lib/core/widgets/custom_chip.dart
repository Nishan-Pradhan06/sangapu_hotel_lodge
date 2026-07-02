import 'package:flutter/material.dart';

/// Enum for chip types
enum ChipType { free, premium }

/// A reusable custom chip that supports Free and Premium styles.
class CustomChip extends StatelessWidget {
  final String label;
  final ChipType type;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomChip({
    super.key,
    required this.label,
    required this.type,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on type
    final Gradient? gradient = type == ChipType.premium
        ? const LinearGradient(
            colors: [Color(0xFFFF7E5F), Color(0xFFFFB347)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;

    final Color backgroundColor = type == ChipType.free
        ? const Color(0xFFF0F0F0)
        : Colors.transparent;

    final Color textColor = type == ChipType.premium
        ? Colors.white
        : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color:
                    (type == ChipType.premium
                            ? const Color(0xFFFF7E5F)
                            : Colors.black)
                        .withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
