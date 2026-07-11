import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../routers/app_routes_names.dart';
import '../../reports/widgets/earning_cards.dart';
import '../../statements/widgets/transcation_tile.dart';
import '../blocs/bloc/get_income_bloc.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Semantic amount colors sourced from AppTheme, not hardcoded here.

    return Scaffold(
      appBar: AppBar(
        title: Text('Income', style: TextTheme.of(context).titleLarge),
      ),

      body: RefreshIndicator.adaptive(
        onRefresh: () {
          context.read<GetIncomeBloc>().add(const GetIncomeEvent.getIncome());
          return Future.value();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: CustomPadding(
            horizontal: 20,
            child: BlocBuilder<GetIncomeBloc, GetIncomeState>(
              builder: (context, state) {
                return state.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (income) {
                    if (income.data.isEmpty) {
                      return Center(
                        child: Text(
                          'No income recorded yet.',
                          style: TextTheme.of(context).bodyMedium,
                        ),
                      );
                    }
                    return Column(
                      children: [
                        EarningsCard(
                          title: 'Total Daily Income',
                          amount: "Rs ${income.summary.dailyIncome.toString()}",
                          backgroundColor: Color(
                            0xFF0b807b,
                          ).withValues(alpha: 0.9),
                          subtitle: 'Total Record of a Day',
                          icon: Icons.show_chart_rounded,
                        ),
                        SizedBox(height: 16),
                        EarningsCard(
                          title: 'Total Monthly Income',
                          amount:
                              "Rs ${income.summary.monthlyIncome.toString()}",
                          backgroundColor: Color(
                            0xFF06754b,
                          ).withValues(alpha: 0.9),
                          subtitle: 'Total Record of a Month',
                          icon: Icons.show_chart_rounded,
                        ),
                        SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Income List',
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
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: income.data.length,
                          itemBuilder: (context, index) {
                            final incomeItem = income.data[index];
                            return Column(
                              children: [
                                TransactionTile(
                                  title: Text(
                                    "${incomeItem.category} | ${incomeItem.remarks}",
                                    style: textTheme.titleSmall,
                                  ),
                                  dateTime: Text(
                                    incomeItem.nepaliDate,
                                    style: textTheme.bodySmall,
                                  ),
                                  amount: Text(
                                    " +${incomeItem.amount.toString()}",
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppTheme.success,
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
                                      AppRoutesName.editRoomEntry,
                                      extra: incomeItem,
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
                  failure: (failure) => Center(
                    child: Text(
                      'Failed to load income.',
                      style: TextTheme.of(context).bodyMedium,
                    ),
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
