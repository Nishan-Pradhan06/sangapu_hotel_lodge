import 'package:go_router/go_router.dart';
import '../../common/extension/extension.dart';
import '../../core/services/cache_service.dart';
import '../../features/auth/screens/login_page.dart';
import '../app_routes_names.dart';

List<GoRoute> authRoutes = [
  GoRoute(
    redirect: (context, state) async {
      final data = await CacheServices.instance.getAuthToken();

      if (data != null) {
        return AppRoutesName.bottomNavRoutePage.path;
      }
      return null;
    },
    path: AppRoutesName.loginScreenRoute.path,
    name: AppRoutesName.loginScreenRoute,

    builder: (context, state) => LoginPage(),
  ),
];
