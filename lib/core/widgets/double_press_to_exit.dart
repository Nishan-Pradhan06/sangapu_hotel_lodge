import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'custom_toast.dart';

class DoubleBackToExit extends StatefulWidget {
  final Widget child;
  final Duration timeout;

  const DoubleBackToExit({
    super.key,
    required this.child,
    this.timeout = const Duration(seconds: 2),
  });

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;

        final GoRouter router = GoRouter.of(context);

        if (router.canPop()) {
          router.pop();
          return;
        }

        final DateTime now = DateTime.now();

        if (_lastBackPressed == null ||
            now.difference(_lastBackPressed!) > widget.timeout) {
          _lastBackPressed = now;
          CustomToast.showInfo('Press back again to exit');
        } else {
          _lastBackPressed = null;
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
