import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/statement_filter_cubit.dart';
import '../bloc/statements_bloc.dart';
import '../../../core/widgets/custom_button.dart';

class MoneyMovementBottomSheet extends StatelessWidget {
  const MoneyMovementBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<StatementFilterCubit>(),
        child: BlocProvider.value(
          value: context.read<StatementsBloc>(),
          child: const MoneyMovementBottomSheet(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   
    final textTheme = theme.textTheme;

    return BlocBuilder<StatementFilterCubit, StatementFilterState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Money Movement',
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildRadioOption(context, 'All', null, state.type),
              _buildRadioOption(context, 'Incoming', 'Income', state.type),
              _buildRadioOption(context, 'Outgoing', 'Expense', state.type),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Show Transactions',
                  onPressed: () {
                    // Filter is already updated in the state on change.
                    final filter = context.read<StatementFilterCubit>().toFilter();
                    context.read<StatementsBloc>().add(
                          StatementsEvent.getStatement(filter: filter),
                        );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioOption(
    BuildContext context,
    String title,
    String? value,
    String? groupValue,
  ) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        context.read<StatementFilterCubit>().setType(value);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.bodyLarge),
            Radio<String?>(
              value: value,
              groupValue: groupValue,
              activeColor: theme.colorScheme.primary,
              onChanged: (newValue) {
                context.read<StatementFilterCubit>().setType(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
