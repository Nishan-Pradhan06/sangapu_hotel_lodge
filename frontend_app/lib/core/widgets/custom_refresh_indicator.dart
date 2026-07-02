import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color color; // indicator color
  final Color backgroundColor; // background color while refreshing
  final double strokeWidth; // thickness of the indicator
  final double displacement; // space from top
  final double radius; // radius of circular indicator

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color = const Color(0xFF6B48FF),
    this.backgroundColor = Colors.white,
    this.strokeWidth = 3.0,
    this.displacement = 40.0,
    this.radius = 20.0,
  });

  @override
  State<CustomRefreshIndicator> createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      strokeWidth: widget.strokeWidth,
      displacement: widget.displacement,
      edgeOffset: 0,
      child: widget.child,
    );
  }
}
