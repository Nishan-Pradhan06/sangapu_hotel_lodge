import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../common/extension/extension.dart';
import 'app_routes_names.dart';
import 'auth_route/auth_routes.dart';
import 'global_route/global_routes.dart';
import 'pages_route/pages_route.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigatorKey',
);

final appRoute = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutesName.gettingStartingPageRoute.path,
  routes: [
    // ...authRoutes.map((r) => _wrapWithTransition(r)),
    ...globalAppRoutes.map((r) => _wrapWithTransition(r)),
    ...pageAppRoutes.map((r) => _wrapWithTransition(r)),
  ],
);

GoRoute _wrapWithTransition(GoRoute route) {
  return GoRoute(
    path: route.path,
    name: route.name,
    redirect: route.redirect,
    routes: route.routes,
    pageBuilder: (context, state) {
      final child = route.builder?.call(context, state);
      if (child == null) return const MaterialPage(child: SizedBox());
      return CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 💫 Try different transitions here:
          // 1️⃣ Slide (from right)

          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );

          // SlideTransition(
          //   position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          //       .animate(
          //         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          //       ),
          //   child: child,
          // );

          // 2️⃣ Fade
          // return FadeTransition(opacity: animation, child: child);

          // 3️⃣ Scale
          // return ScaleTransition(scale: animation, child: child);

          // 4️⃣ Combined (fade + slide)
          // return SlideTransition(
          //   position: Tween(begin: const Offset(1, 0), end: Offset.zero)
          //       .animate(animation),
          //   child: FadeTransition(opacity: animation, child: child),
          // );
        },
      );
    },
  );
}
