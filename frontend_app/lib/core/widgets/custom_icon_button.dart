import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 20,
    this.color = Colors.black,
    this.padding = EdgeInsets.zero, // default no extra padding
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // ensures tap area is valid
      child: Padding(
        padding: padding,
        child: Icon(icon, size: size, color: color),
      ),
    );
  }
}
