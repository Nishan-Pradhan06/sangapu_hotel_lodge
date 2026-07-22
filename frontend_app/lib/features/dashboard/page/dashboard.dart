import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/features/auth/cubits/logout/logout_cubit.dart';

import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../core/widgets/earnings_card_simmer.dart';
import '../../../routers/app_routes_names.dart';
import '../../expenses/blocs/get_expenses/get_expenses_bloc.dart';
import '../../income/blocs/bloc/get_income_bloc.dart';
import '../../reports/widgets/earning_cards.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo/logo.png'),
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
                  context.pushNamed(AppRoutesName.loginScreenRoute);
                  CustomToast.showSuccess(data);
                },
              );
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
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
                            // Call the logout action in your Cubit
                            context.read<LogoutCubit>().logout();
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.logout_outlined),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          context.read<GetIncomeBloc>().add(const GetIncomeEvent.getIncome());
          context.read<GetExpensesBloc>().add(
            const GetExpensesEvent.getExpenses(),
          );
          return Future.value();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: CustomPadding(
            child: Column(
              spacing: 20,
              children: [
                BlocBuilder<GetIncomeBloc, GetIncomeState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const EarningsCardShimmer(),
                      loading: () => EarningsCardShimmer(),
                      failure: (failure) => Center(
                        child: Text(
                          'Failed to load income: ${failure.message}',
                          style: TextTheme.of(context).bodyMedium,
                        ),
                      ),
                      loaded: (income) {
                        return Column(
                          spacing: 20,

                          children: [
                            EarningsCard(
                              title: 'Today Earnings',
                              amount:
                                  "Rs ${income.summary.dailyIncome.toString()}",
                              backgroundColor: const Color(
                                0xFF1A237E,
                              ).withValues(alpha: 0.9),
                              subtitle: 'Total Record of a Day',
                              icon: Icons.show_chart_rounded,
                            ),

                            EarningsCard(
                              title: 'Total Monthly Earnings',
                              amount:
                                  "Rs ${income.summary.monthlyIncome.toString()}",
                              backgroundColor: const Color(
                                0xFFFF9800,
                              ).withValues(alpha: 0.8),
                              icon: Icons.calendar_month_rounded,
                              subtitle: 'On Track for target',
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                BlocBuilder<GetExpensesBloc, GetExpensesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => EarningsCardShimmer(),
                      loading: () => EarningsCardShimmer(),
                      failure: (failure) => Center(
                        child: Text(
                          'Failed to load expenses: ${failure.message}',
                          style: TextTheme.of(context).bodyMedium,
                        ),
                      ),
                      loaded: (expenses) {
                        return EarningsCard(
                          title: 'Total Daily Expenses',
                          amount:
                              "Rs ${expenses.summary.totalDailyExpenses.toString()}",
                          backgroundColor: const Color(
                            0xFF7e1a44,
                          ).withValues(alpha: 0.9),
                          subtitle: 'Total Record of a Day',
                          icon: Icons.show_chart_rounded,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'bottom_nav_fab',
        onPressed: () {
          context.pushNamed(AppRoutesName.createRoomEntryPage);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
