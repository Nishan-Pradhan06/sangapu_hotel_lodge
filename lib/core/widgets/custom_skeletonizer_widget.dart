import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSkeletonizerWidget extends StatelessWidget {
  final Widget child;
  final bool isEnabled;
  const CustomSkeletonizerWidget({
    super.key,
    required this.child,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: child);
  }
}
