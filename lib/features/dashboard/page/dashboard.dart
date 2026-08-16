import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/core/widgets/custom_toast.dart';
import 'package:sangapu/features/auth/cubits/logout/logout_cubit.dart';
import 'package:sangapu/features/banners/blocs/get_banner/get_banner_bloc.dart';
import 'package:sangapu/main.dart';

import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/earnings_card_simmer.dart';
import '../../../routers/app_routes_names.dart';
import '../../banners/widgets/banner_widget.dart';
import '../../expenses/blocs/get_expenses/get_expenses_bloc.dart';
import '../../income/blocs/bloc/get_income_bloc.dart';
import '../../reports/widgets/earning_cards.dart';
import '../../statements/bloc/statements_bloc.dart';
import '../widgets/room_bevereage.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Pull-to-refresh triggers all blocs including statements
  Future<void> _handleRefresh(BuildContext context) async {
    context.read<GetIncomeBloc>().add(const GetIncomeEvent.getIncome());
    context.read<GetBannerBloc>().add(const GetBannerEvent.getBanner());
    context.read<GetExpensesBloc>().add(const GetExpensesEvent.getExpenses());
    context.read<StatementsBloc>().add(const StatementsEvent.getStatement());
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<LogoutCubit>().logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logo.png'),
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SHANGAPU HOTEL & LODGE',
              style: TextTheme.of(context).titleLarge,
            ),
            Text(
              DateHelper.nepaliDate(),
              style: TextTheme.of(context).bodySmall,
            ),
          ],
        ),
        actions: [
          BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (failure) {
                  CustomToast.showError(failure.message);
                },
                loaded: (data) {
                  context.goNamed(AppRoutesName.loginScreenRoute);
                  RestartWidget.restartApp(context);
                  CustomToast.showSuccess(data);
                },
              );
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout_outlined),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _handleRefresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            spacing: 20,
            children: [
              CustomPadding(child: const BannerWidget()),
              SummaryTableDemo(),
              // 1. INCOME BLOC
              BlocBuilder<GetIncomeBloc, GetIncomeState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const CardShimmer(),
                    loading: () => const CardShimmer(),
                    failure: (failure) => Center(
                      child: Text(
                        'Failed to load income: ${failure.message}',
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    ),
                    loaded: (income) {
                      return CustomPadding(
                        child: Column(
                          spacing: 20,
                          children: [
                            EarningsCard(
                              title: 'Today Earnings',
                              amount: "Rs ${income.summary.dailyIncome}",
                              backgroundColor: const Color(0xFF2563EB),
                              subtitle: 'Total Record of a Day',
                              icon: Icons.show_chart_rounded,
                            ),
                            EarningsCard(
                              title: 'Total Monthly Earnings',
                              amount: "Rs ${income.summary.monthlyIncome}",
                              backgroundColor: const Color(0xFF0EA5E9),
                              icon: Icons.calendar_month_rounded,
                              subtitle: 'On Track for target',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              // 2. EXPENSES BLOC
              BlocBuilder<GetExpensesBloc, GetExpensesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const CardShimmer(),
                    loading: () => const CardShimmer(),
                    failure: (failure) => Center(
                      child: Text(
                        'Failed to load expenses: ${failure.message}',
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    ),
                    loaded: (expenses) {
                      return CustomPadding(
                        vertical: 0,
                        child: EarningsCard(
                          title: 'Total Daily Expenses',
                          amount: "Rs ${expenses.summary.totalDailyExpenses}",
                          backgroundColor: const Color(0xFFE11D48),
                          subtitle: 'Total Record of a Day',
                          icon: Icons.trending_down_rounded,
                        ),
                      );
                    },
                  );
                },
              ),

              // --- SECTION DIVIDER ---
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'NET SUMMARY',
                      style: TextTheme.of(context).labelSmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),

              // 3. STATEMENTS / NET INCOME BLOC
              BlocBuilder<StatementsBloc, StatementsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const CardShimmer(),
                    loading: () => const CardShimmer(),
                    failure: (failure) => Center(
                      child: Text(
                        'Failed to load statements: ${failure.message}',
                        style: TextTheme.of(context).bodyMedium,
                      ),
                    ),
                    loaded: (netIncome) {
                      return CustomPadding(
                        vertical: 0,
                        child: EarningsCard(
                          title: 'Total Net Earnings after Expenses',
                          amount: "Rs ${netIncome.summary.netBalance}",
                          backgroundColor: const Color(0xFF059669),
                          icon: Icons.account_balance_wallet_rounded,
                          subtitle: 'On Track for target',
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'bottom_nav_fab',
        onPressed: () {
          context.pushNamed(AppRoutesName.incomeEntry);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
