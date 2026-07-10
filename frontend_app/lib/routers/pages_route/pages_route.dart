import 'package:go_router/go_router.dart';
import 'package:sangapu/features/expenses/page/edit_expenses.dart';
import 'package:sangapu/features/rooms/models/room_entry_model.dart';
import 'package:sangapu/features/rooms/page/edit_room_entry_page.dart';
import '../../common/extension/extension.dart';
import '../../features/dashboard/page/dashboard.dart';
import '../../features/expenses/page/add_expenses.dart';
import '../../features/expenses/models/expenses_response.dart';
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
  GoRoute(
    path: AppRoutesName.addExpense.path,
    name: AppRoutesName.addExpense,
    builder: (context, state) => AddExpenses(),
  ),
  GoRoute(
    path: AppRoutesName.editExpense.path,
    name: AppRoutesName.editExpense,
    builder: (context, state) {
      final expense = state.extra as Expense;
      return EditExpenses(expense: expense);
    },
  ),
  GoRoute(
    path: AppRoutesName.editRoomEntry.path,
    name: AppRoutesName.editRoomEntry,
    builder: (context, state) {
      final roomEntry = state.extra as RoomEntryModel;
      return EditRoomEntryPage();
    },
  ),
];
