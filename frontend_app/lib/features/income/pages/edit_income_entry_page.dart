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
import '../../../core/helpers/nepali_date_helper.dart';
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
  late final TextEditingController _regularPriceController;
  late final TextEditingController _customPriceController;
  late final TextEditingController _additionalNotesController;

  Map<String, String> incomeTypeMap = {
    'Room': 'room',
    'Food': 'food',
    'Others': 'others',
  };

  @override
  void initState() {
    super.initState();
    // Pre-fill from the incoming IncomeData.
    
    String initialIncomeType = '';
    incomeTypeMap.forEach((key, value) {
      if (value == widget.incomeData.incomeType) {
        initialIncomeType = key;
      }
    });
    _incomeTypeController = TextEditingController(text: initialIncomeType);

    // If the amount matches one of the fixed rates AND type is Room, show it in the dropdown;
    // otherwise fall back to the custom price field.
    final fixedRates = [800, 900, 1000, 1100, 1200];
    if (fixedRates.contains(widget.incomeData.amount) && widget.incomeData.incomeType == 'room') {
      _regularPriceController = TextEditingController(
        text: 'Rs. ${widget.incomeData.amount}',
      );
      _customPriceController = TextEditingController();
    } else {
      _regularPriceController = TextEditingController(
        text: 'Select a standard rate',
      );
      _customPriceController = TextEditingController(
        text: widget.incomeData.amount.toString(),
      );
    }
    _additionalNotesController = TextEditingController(
      text: widget.incomeData.remarks,
    );
  }


  @override
  void dispose() {
    _incomeTypeController.dispose();
    _regularPriceController.dispose();
    _customPriceController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Income Entry', style: TextTheme.of(context).titleLarge),
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
                  dropdownItems: const [
                    'Select a Income Type',
                    'Room',
                    'Food',
                    'Others',
                  ],
                  hint: 'Select a Income Type',
                  onDropdownChanged: (value) {
                    if (value != 'Room') {
                      _regularPriceController.text = 'Select a standard rate';
                    }
                    setState(() {});
                  },
                  onChanged: (value) {
                    if (value != 'Room') {
                      _regularPriceController.text = 'Select a standard rate';
                    }
                    setState(() {});
                  },
                ),
                CustomTextField(
                  key: ValueKey(
                    'regular_price_${_customPriceController.text.isNotEmpty}_${_regularPriceController.text}',
                  ),
                  label: 'Regular Price',
                  type: CustomTextFieldType.dropdown,
                  controller: _regularPriceController,
                  enabled:
                      _incomeTypeController.text == 'Room' &&
                      _customPriceController.text.isEmpty,
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
      bottomNavigationBar:
          BlocConsumer<EditIncomeEntryBloc, EditIncomeEntryState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (failure) {
                  CustomToast.showError(failure.message);
                },
                loaded: (data) {
                  CustomToast.showSuccess('Income entry updated successfully');
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
                          nepaliDate: widget.incomeData.nepaliDate,
                        );

                        context.read<EditIncomeEntryBloc>().add(
                          EditIncomeEntryEvent.editIncomeEntry(
                            widget.incomeData.id,
                            incomeEntryModel,
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
