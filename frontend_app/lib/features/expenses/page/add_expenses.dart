import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../statements/bloc/statements_bloc.dart';
import '../blocs/bloc/add_expenses_record_bloc.dart';
import '../blocs/get_expenses/get_expenses_bloc.dart';
import '../models/create_expenses.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final _formKey = GlobalKey<FormState>();
  final _expensesTypeController = TextEditingController();
  final _expensesAmountController = TextEditingController();
  final _remarkController = TextEditingController();

  Map<String, String> expenseCategoryMap = {
    'Electricity Bill': 'electricity',
    'Staff Salary': 'staff_salary',
    'Water Bill': 'water',
    'Maintenance': 'maintenance',
    'Others': 'others',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expenses', style: TextTheme.of(context).titleLarge),
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
                        DateHelper.nepaliDate(),
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
                  enabled: _expensesAmountController.text.isEmpty,
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
                  keyboardType: TextInputType.numberWithOptions(),
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
          BlocConsumer<AddExpensesRecordBloc, AddExpensesRecordState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (failure) {
                  CustomToast.showError(failure.message);
                },
                loaded: (data) {
                  CustomToast.showSuccess("Add Expenses Successfully");
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
                        context.read<AddExpensesRecordBloc>().add(
                          AddExpensesRecordEvent.addExpensesRecord(
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
                              nepaliDate: DateHelper.nepaliDate(),
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
