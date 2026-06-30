import 'package:go_router/go_router.dart';
import 'package:sangapu/features/home/pages/home_screen.dart';
import '../../common/extension/extension.dart';
import '../app_routes_names.dart';

List<GoRoute> pageAppRoutes = [
  GoRoute(
    path: AppRoutesName.learnerHomePage.path,
    name: AppRoutesName.learnerHomePage,
    builder: (context, state) => HomeScreen(),
  ),
];
