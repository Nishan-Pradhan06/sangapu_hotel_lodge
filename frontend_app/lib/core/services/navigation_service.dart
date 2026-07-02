import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routers/app_router.dart';

class NavigationService {
  // Get the GoRouter instance from AppRouter
  final GoRouter _router = appRoute;

  // Expose the root navigator key if direct NavigatorState access is needed
  // for operations like showing dialogs/bottom sheets not tied to a declarative route.
  GlobalKey<NavigatorState> get navigatorKey => rootNavigatorKey;

  /// Navigates to a new screen using its route path.
  /// This is equivalent to `GoRouter.go()`.
  void go(String location, {Object? extra}) {
    _router.go(location, extra: extra);
  }

  /// Pushes a new screen onto the stack using its route path.
  /// This is equivalent to `GoRouter.push()`.
  Future<T?>? push<T extends Object?>(String location, {Object? extra}) {
    return _router.push<T>(location, extra: extra);
  }

  /// Navigates to a named route.
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Pushes a named route onto the stack.
  Future<T?>? pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return _router.pushNamed<T>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Pops the current route from the navigator.
  void pop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop(result);
    }
  }

  /// Shows a dialog globally using the rootNavigatorKey.
  Future<T?> showGlobalDialog<T>({required WidgetBuilder builder}) {
    if (navigatorKey.currentContext != null) {
      return showDialog<T>(
        context: navigatorKey.currentContext!,
        builder: builder,
      );
    }
    return Future.value(null); // Or handle error appropriately
  }
}
