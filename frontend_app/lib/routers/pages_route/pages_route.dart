import 'package:go_router/go_router.dart';
import '../../common/extension/extension.dart';
import '../../features/reports/pages/report_overview_page.dart';
import '../../features/rooms/page/create_room_page.dart';
import '../app_routes_names.dart';

List<GoRoute> pageAppRoutes = [
  GoRoute(
    path: AppRoutesName.reportOverviewPage.path,
    name: AppRoutesName.reportOverviewPage,
    builder: (context, state) => ReportOverviewPage(),
  ),
  GoRoute(
    path: AppRoutesName.createRoomEntryPage.path,
    name: AppRoutesName.createRoomEntryPage,
    builder: (context, state) => CreateRoomEntryPage(),
  ),
];
