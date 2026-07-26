import 'package:flutter/widgets.dart';

class CustomPadding extends StatelessWidget {
  final Widget child;
  final double horizontal;
  final double vertical;

  const CustomPadding({
    super.key,
    required this.child,
    this.horizontal = 20.0, // default
    this.vertical = 14.0, // default
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}
