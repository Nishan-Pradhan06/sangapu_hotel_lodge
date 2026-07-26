import 'package:flutter/material.dart';

class ScrollableRefreshablePadding extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final ScrollPhysics? physics;

  const ScrollableRefreshablePadding({
    super.key,
    required this.onRefresh,
    required this.child,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        child: SafeArea(child: child),
      ),
    );
  }
}
