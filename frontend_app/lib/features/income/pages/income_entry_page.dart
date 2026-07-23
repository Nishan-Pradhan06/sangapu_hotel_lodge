import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/core/widgets/custom_button.dart';
import 'package:sangapu/core/widgets/custom_container.dart';
import 'package:sangapu/core/widgets/custom_padding.dart';
import 'package:sangapu/core/widgets/custom_text_form_field.dart';
import 'package:sangapu/features/income/blocs/bloc/get_income_bloc.dart';
import 'package:sangapu/features/income/blocs/income_entry/income_entry_bloc.dart';
import 'package:sangapu/features/income/model/income_entry_model.dart';
import 'package:sangapu/features/statements/bloc/statements_bloc.dart';
import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../expenses/blocs/get_expenses/get_expenses_bloc.dart';

class IncomeEntryPage extends StatefulWidget {
  const IncomeEntryPage({super.key});

  @override
  State<IncomeEntryPage> createState() => _IncomeEntryPageState();
}

class _IncomeEntryPageState extends State<IncomeEntryPage> {
  final _formKey = GlobalKey<FormState>();

  final _incomeTypeController = TextEditingController();
  final _regularPriceController = TextEditingController();
  final _customPriceController = TextEditingController();
  final _additionalNotesController = TextEditingController();

  @override
  void dispose() {
    _incomeTypeController.dispose();
    _regularPriceController.dispose();
    _customPriceController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  Map<String, String> incomeTypeMap = {
    'Room': 'room',
    'Food': 'food',
    'Others': 'others',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Income Entry')),
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
                        DateHelper.nepaliDateDash(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  key: ValueKey(
                    'income_type_${_incomeTypeController.text.isNotEmpty}_${_incomeTypeController.text}',
                  ),
                  label: 'Income Type',
                  type: CustomTextFieldType.dropdown,
                  controller: _incomeTypeController,
                  enabled: _incomeTypeController.text.isEmpty,
                  dropdownItems: const [
                    'Select a Income Type',
                    'Room',
                    'Food',
                    'Others',
                  ],
                  hint: 'Select a Income Type',
                ),
                CustomTextField(
                  key: ValueKey(
                    'regular_price_${_customPriceController.text.isNotEmpty}_${_regularPriceController.text}',
                  ),
                  label: 'Regular Price',
                  type: CustomTextFieldType.dropdown,
                  controller: _regularPriceController,
                  enabled: _customPriceController.text.isEmpty,
                  dropdownItems: const [
                    'Select a standard rate',
                    'Rs. 800',
                    'Rs. 900',
                    'Rs. 1000',
                    'Rs. 1100',
                    'Rs. 1200',
                  ],
                  hint: 'Select a standard rate',
                  onDropdownChanged: (value) {
                    if (value != 'Select a standard rate' && value != null) {
                      _customPriceController.clear();
                      setState(() {});
                    }
                  },
                ),
                CustomTextField(
                  controller: _customPriceController,
                  label: 'Enter Custom Amount',
                  hint: '0.00',
                  type: CustomTextFieldType.number,
                  keyboardType: const TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _regularPriceController.text = 'Select a standard rate';
                    }
                    setState(() {});
                  },
                ),
                CustomTextField(
                  label: 'Additional Notes',
                  controller: _additionalNotesController,
                  maxLines: 8,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<IncomeEntryBloc, IncomeEntryState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (failure) {
              CustomToast.showError(failure.message);
            },
            loaded: (data) {
              CustomToast.showSuccess("Income entry successful");
              context.read<StatementsBloc>().add(
                const StatementsEvent.getStatement(),
              );
              context.read<GetIncomeBloc>().add(
                const GetIncomeEvent.getIncome(),
              );
              context.read<GetExpensesBloc>().add(
                const GetExpensesEvent.getExpenses(),
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
                    int? parsedFixedPrice;
                    if (_regularPriceController.text !=
                            'Select a standard rate' &&
                        _regularPriceController.text.isNotEmpty) {
                      final match = RegExp(
                        r'\d+',
                      ).firstMatch(_regularPriceController.text);
                      if (match != null) {
                        parsedFixedPrice = int.tryParse(match.group(0)!);
                      }
                    }

                    final incomeEntryModel = IncomeEntryModel(
                      incomeType:
                          incomeTypeMap[_incomeTypeController.text] ?? '',
                      regularPrice: parsedFixedPrice,
                      customPrice: _customPriceController.text,
                      additionalNotes: _additionalNotesController.text,
                      nepaliDate: DateHelper.nepaliDateDash(),
                    );
                    context.read<IncomeEntryBloc>().add(
                      IncomeEntryEvent.incomeEntry(incomeEntryModel),
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
