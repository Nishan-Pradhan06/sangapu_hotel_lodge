import 'package:go_router/go_router.dart';
import '../../common/extension/extension.dart';
import '../../features/income/dashboard/page/dashboard.dart';
import '../../features/rooms/page/create_room_page.dart';
import '../app_routes_names.dart';

List<GoRoute> pageAppRoutes = [
  GoRoute(
    path: AppRoutesName.dashboardPage.path,
    name: AppRoutesName.dashboardPage,
    builder: (context, state) => DashboardPage(),
  ),
  GoRoute(
    path: AppRoutesName.createRoomEntryPage.path,
    name: AppRoutesName.createRoomEntryPage,
    builder: (context, state) => CreateRoomEntryPage(),
  ),
];
