import 'package:flutter/material.dart';

/// A reusable custom background container with gradient.
/// Wraps any child widget and fills the whole screen by default.
class CustomBackground extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  const CustomBackground({
    super.key,
    required this.child,
    this.colors = const [Color(0xFFE6E1FF), Color(0xFFFFFFFF)],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: begin, end: end),
      ),
      child: child,
    );
  }
}
