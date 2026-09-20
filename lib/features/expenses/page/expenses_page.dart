import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/features/expenses/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:sangapu/routers/app_routes_names.dart';

import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_state_widget.dart';
import '../../reports/widgets/earning_cards.dart';
import '../../statements/widgets/transcation_tile.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Semantic amount colors sourced from AppTheme, not hardcoded here.
    final negativeColor = colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses', style: TextTheme.of(context).titleLarge),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_expense_fab',

        onPressed: () {
          context.pushNamed(AppRoutesName.addExpense);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          context.read<GetExpensesBloc>().add(
            const GetExpensesEvent.getExpenses(),
          );
          return Future.value();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: CustomPadding(
            horizontal: 20,
            child: BlocBuilder<GetExpensesBloc, GetExpensesState>(
              builder: (context, state) {
                return state.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (expenses) {
                    return Column(
                      children: [
                        EarningsCard(
                          borderRadius: BorderRadius.circular(20),

                          title: 'Total Daily Expenses',
                          amount:
                              "Rs ${expenses.summary.totalDailyExpenses.toString()}",
                          backgroundColor: const Color(
                            0xFF7e1a44,
                          ).withValues(alpha: 0.9),
                          subtitle: 'Total Record of a Day',
                          icon: Icons.show_chart_rounded,
                        ),
                        SizedBox(height: 16),
                        EarningsCard(
                          borderRadius: BorderRadius.circular(20),

                          title: 'Total Monthly Expenses',
                          amount:
                              "Rs ${expenses.summary.totalMonthlyExpenses.toString()}",
                          backgroundColor: const Color(
                            0xFF7e1a44,
                          ).withValues(alpha: 0.9),
                          subtitle: 'Total Record of a Month',
                          icon: Icons.show_chart_rounded,
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Expenses List',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'To Edit expenses press and hold on list until edit page appear.',
                            style: textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        if (expenses.data.isEmpty)
                          const EmptyStateWidget(
                            icon: Icons.receipt_long_outlined,
                            title: 'No Expenses Recorded Yet',
                            message:
                                'You haven\'t recorded any expense entries yet.\nTap the + button below to create your first entry.',
                          )
                        else
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: expenses.data.length,
                            itemBuilder: (context, index) {
                              final expense = expenses.data[index];
                              return Column(
                                children: [
                                  TransactionTile(
                                    title: Text(
                                      "${expense.category} | ${expense.remarks}",
                                      style: textTheme.titleSmall,
                                    ),
                                    dateTime: Text(
                                      expense.nepaliDate,
                                      style: textTheme.bodySmall,
                                    ),
                                    amount: Text(
                                      " -${expense.amount.toString()}",
                                      style: textTheme.titleMedium?.copyWith(
                                        color: negativeColor,
                                      ),
                                    ),
                                    balance: Text(
                                      "",
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    onLongPress: () {
                                      context.pushNamed(
                                        AppRoutesName.editExpense,
                                        extra: expense,
                                      );
                                    },
                                  ),
                                  Divider(color: colorScheme.outline, height: 32),
                                ],
                              );
                            },
                          ),
                      ],
                    );
                  },
                  failure: (failure) => ErrorStateWidget(
                    title: 'Unable to Load Expenses',
                    message: failure.message.isNotEmpty
                        ? failure.message
                        : 'Please check your internet connection and try again.',
                    onRetry: () => context
                        .read<GetExpensesBloc>()
                        .add(const GetExpensesEvent.getExpenses()),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
