import 'package:go_router/go_router.dart';
import 'package:sangapu/features/expenses/page/edit_expenses.dart';
import 'package:sangapu/features/income/pages/edit_income_entry_page.dart';
import '../../common/extension/extension.dart';
import '../../features/dashboard/page/dashboard.dart';
import '../../features/expenses/page/add_expenses.dart';
import '../../features/expenses/models/expenses_response.dart';
import '../../features/income/model/income_model.dart';
import '../../features/income/pages/income_entry_page.dart';
import '../app_routes_names.dart';

List<GoRoute> pageAppRoutes = [
  GoRoute(
    path: AppRoutesName.dashboardPage.path,
    name: AppRoutesName.dashboardPage,
    builder: (context, state) => DashboardPage(),
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
    path: AppRoutesName.incomeEntry.path,
    name: AppRoutesName.incomeEntry,
    builder: (context, state) => IncomeEntryPage(),
  ),
  GoRoute(
    path: AppRoutesName.editIncomeEntry.path,
    name: AppRoutesName.editIncomeEntry,
    builder: (context, state) {
      final incomeData = state.extra as IncomeData;
      return EditIncomeEntryPage(incomeData: incomeData);
    },
  ),
];
