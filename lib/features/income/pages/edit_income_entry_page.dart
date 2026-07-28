import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/core/widgets/custom_button.dart';
import 'package:sangapu/core/widgets/custom_container.dart';
import 'package:sangapu/core/widgets/custom_padding.dart';
import 'package:sangapu/core/widgets/custom_text_form_field.dart';
import 'package:sangapu/features/income/blocs/bloc/get_income_bloc.dart';
import 'package:sangapu/features/income/blocs/edit_room_entry/edit_income_entry_bloc.dart';
import 'package:sangapu/features/income/model/income_entry_model.dart';
import 'package:sangapu/features/income/model/income_model.dart';
import 'package:sangapu/features/statements/bloc/statements_bloc.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../expenses/blocs/get_expenses/get_expenses_bloc.dart';

class EditIncomeEntryPage extends StatefulWidget {
  final IncomeData incomeData;

  const EditIncomeEntryPage({super.key, required this.incomeData});

  @override
  State<EditIncomeEntryPage> createState() => _EditIncomeEntryPageState();
}

class _EditIncomeEntryPageState extends State<EditIncomeEntryPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _incomeTypeController; 
  late final TextEditingController _customPriceController;
  late final TextEditingController _additionalNotesController;

  static const Map<String, String> _incomeTypeMap = {
    'Room': 'rooms',
    'Beverage': 'beverage',
    'Others': 'others',
  };

  @override
  void initState() {
    super.initState();

    // Map incoming income type string (e.g. 'room') back to dropdown display key (e.g. 'Room')
    String initialIncomeType = '';
    _incomeTypeMap.forEach((key, value) {
      if (value == widget.incomeData.incomeType) {
        initialIncomeType = key;
      }
    });

    _incomeTypeController = TextEditingController(text: initialIncomeType);
    _customPriceController = TextEditingController(
      text: widget.incomeData.amount.toString(),
    );
    _additionalNotesController = TextEditingController(
      text: widget.incomeData.remarks,
    );
  }

  @override
  void dispose() {
    _incomeTypeController.dispose();
    _customPriceController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final selectedTypeKey = _incomeTypeController.text.trim();
    final mappedType = _incomeTypeMap[selectedTypeKey] ?? '';

    if (mappedType.isEmpty) {
      CustomToast.showError('Please select a valid income type');
      return;
    }

    final incomeEntryModel = IncomeEntryModel(
      incomeType: mappedType,
      regularPrice: null,
      customPrice: _customPriceController.text.trim(),
      additionalNotes: _additionalNotesController.text.trim(),
      nepaliDate: widget.incomeData.nepaliDate,
    );

    context.read<EditIncomeEntryBloc>().add(
      EditIncomeEntryEvent.editIncomeEntry(
        widget.incomeData.id,
        incomeEntryModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping away from inputs
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Income Entry',
            style: TextTheme.of(context).titleLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: CustomPadding(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- DATE DISPLAY CARD ---
                  CustomContainer(
                    borderRadius: BorderRadius.circular(10),
                    useIntrinsicHeight: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DATE OF ENTRY',
                          style: TextTheme.of(
                            context,
                          ).titleMedium?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.incomeData.nepaliDate,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // --- INCOME TYPE DROPDOWN ---
                  CustomTextField(
                    label: 'Income Type',
                    type: CustomTextFieldType.dropdown,
                    controller: _incomeTypeController,
                    dropdownItems: const [
                      'Select an Income Type',
                      'Room',
                      'Beverage',
                      'Others',
                    ],
                    hint: 'Select an Income Type',
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Select an Income Type') {
                        return 'Please select an income type';
                      }
                      return null;
                    },
                  ),

                  // --- AMOUNT FIELD ---
                  CustomTextField(
                    controller: _customPriceController,
                    label: 'Amount (NPR)',
                    hint: '0.00',
                    type: CustomTextFieldType.number,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter an amount';
                      }
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null || parsed <= 0) {
                        return 'Please enter a valid amount greater than 0';
                      }
                      return null;
                    },
                  ),

                  // --- ADDITIONAL NOTES ---
                  CustomTextField(
                    label: 'Additional Notes',
                    controller: _additionalNotesController,
                    hint: 'Enter any additional details or notes here...',
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            BlocConsumer<EditIncomeEntryBloc, EditIncomeEntryState>(
              listener: (context, state) {
                state.whenOrNull(
                  failure: (failure) {
                    CustomToast.showError(failure.message);
                  },
                  loaded: (data) {
                    CustomToast.showSuccess(
                      'Income entry updated successfully',
                    );

                    // Refresh state across BLoCs
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
                      text: 'Update Entry',
                      onPressed: _submitForm,
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
