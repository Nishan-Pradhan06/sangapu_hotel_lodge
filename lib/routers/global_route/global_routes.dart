import 'package:go_router/go_router.dart';
import 'package:sangapu/features/global_page/bottom_nav_bar.dart';
import '../../common/extension/extension.dart';
import '../app_routes_names.dart';

List<GoRoute> globalAppRoutes = [
  // GoRoute(
  //   redirect: (context, state) async {
  //     // final data = await sl<OnceCacheService>().getOnGettingStartCache();

  //     if (data != null) {
  //       return AppRoutesName.loginScreenRoute.path;
  //     }
  //     return null;
  //   },
  //   path: AppRoutesName.gettingStartingPageRoute.path,
  //   name: AppRoutesName.gettingStartingPageRoute,
  //   builder: (context, state) => GettingStartingPage(),
  // ),
  GoRoute(
    path: AppRoutesName.bottomNavRoutePage.path,
    name: AppRoutesName.bottomNavRoutePage,
    builder: (context, state) => BottomNavBarPage(),
  ),
];
