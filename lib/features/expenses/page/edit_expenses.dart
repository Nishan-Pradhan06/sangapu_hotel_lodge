import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../statements/bloc/statements_bloc.dart';
import '../blocs/edit_expenses/edit_expenses_bloc.dart';
import '../blocs/get_expenses/get_expenses_bloc.dart';
import '../models/create_expenses.dart';
import '../models/expenses_response.dart';

class EditExpenses extends StatefulWidget {
  final Expense expense;
  const EditExpenses({super.key, required this.expense});

  @override
  State<EditExpenses> createState() => _EditExpensesState();
}

class _EditExpensesState extends State<EditExpenses> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _expensesTypeController;
  late TextEditingController _expensesAmountController;
  late TextEditingController _remarkController;

  Map<String, String> expenseCategoryMap = {
    'Electricity Bill': 'electricity',
    'Staff Salary': 'staff_salary',
    'Water Bill': 'water',
    'Maintenance': 'maintenance',
    'Others': 'others',
  };

  String _getCategoryKey(String value) {
    return expenseCategoryMap.entries
        .firstWhere((element) => element.value == value,
            orElse: () => const MapEntry('Others', 'others'))
        .key;
  }

  @override
  void initState() {
    super.initState();
    _expensesTypeController = TextEditingController(text: _getCategoryKey(widget.expense.category));
    _expensesAmountController = TextEditingController(text: widget.expense.amount.toString());
    _remarkController = TextEditingController(text: widget.expense.remarks);
  }

  @override
  void dispose() {
    _expensesTypeController.dispose();
    _expensesAmountController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expenses', style: TextTheme.of(context).titleLarge),
      ),
      body: SingleChildScrollView(
        child: CustomPadding(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              children: [
                CustomContainer(
                  borderRadius: BorderRadius.circular(10),
                  useIntrinsicHeight: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DATE OF ENTRY',
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        widget.expense.nepaliDate,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  key: ValueKey(
                    'dropdown_${_expensesAmountController.text.isNotEmpty}_${_expensesTypeController.text}',
                  ),
                  label: 'Expense Type',
                  type: CustomTextFieldType.dropdown,
                  controller: _expensesTypeController,
                  enabled: true,
                  dropdownItems: const [
                    'Select a Expense Type',
                    'Electricity Bill',
                    'Staff Salary',
                    'Water Bill',
                    'Maintenance',
                    'Others',
                  ],
                  hint: 'Select a Expense Type',
                ),
                CustomTextField(
                  controller: _expensesAmountController,
                  label: 'Expense Amount',
                  hint: '0.00',
                  type: CustomTextFieldType.number,
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  label: 'Remarks',
                  controller: _remarkController,
                  maxLines: 8,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<EditExpensesBloc, EditExpensesState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (failure) {
                  CustomToast.showError(failure.message);
                },
                loaded: (data) {
                  CustomToast.showSuccess("Edit Expenses Successfully");
                  context.read<GetExpensesBloc>().add(
                    const GetExpensesEvent.getExpenses(),
                  );
                  context.read<StatementsBloc>().add(
                    const StatementsEvent.getStatement(),
                  );
                  context.pop();
                },
              );
            },
            builder: (context, state) {
              final bool isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );
              return CustomPadding(
                child: SizedBox(
                  height: MediaQuery.heightOf(context) / 14,
                  child: CustomButton(
                    isLoading: isLoading,
                    isDisabled: isLoading,
                    text: 'Save',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<EditExpensesBloc>().add(
                          EditExpensesEvent.editExpense(
                            widget.expense.id,
                            ExpensesRecordModel(
                              category:
                                  expenseCategoryMap[_expensesTypeController
                                      .text] ??
                                  '',
                              amount:
                                  double.tryParse(
                                    _expensesAmountController.text,
                                  ) ??
                                  0.0,
                              remarks: _remarkController.text,
                              nepaliDate: widget.expense.nepaliDate,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
    );
  }
}
