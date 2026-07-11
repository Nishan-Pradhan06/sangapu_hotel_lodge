import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/core/widgets/custom_button.dart';
import 'package:sangapu/core/widgets/custom_container.dart';
import 'package:sangapu/core/widgets/custom_padding.dart';
import 'package:sangapu/core/widgets/custom_text_form_field.dart';
import 'package:sangapu/features/income/blocs/bloc/get_income_bloc.dart';
import 'package:sangapu/features/income/model/income_model.dart';
import 'package:sangapu/features/rooms/blocs/edit_room_entry/edit_room_entry_bloc.dart';
import 'package:sangapu/features/rooms/models/room_entry_model.dart';
import 'package:sangapu/features/statements/bloc/statements_bloc.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../expenses/blocs/get_expenses/get_expenses_bloc.dart';

class EditRoomEntryPage extends StatefulWidget {
  final IncomeData incomeData;
  const EditRoomEntryPage({super.key, required this.incomeData});

  @override
  State<EditRoomEntryPage> createState() => _EditRoomEntryPageState();
}

class _EditRoomEntryPageState extends State<EditRoomEntryPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _regularPriceController;
  late final TextEditingController _customPriceController;
  late final TextEditingController _additionalNotesController;

  @override
  void initState() {
    super.initState();
    // Pre-fill from the incoming IncomeData.
    // If the amount matches one of the fixed rates, show it in the dropdown;
    // otherwise fall back to the custom price field.
    final fixedRates = [800, 900, 1000, 1100, 1200];
    if (fixedRates.contains(widget.incomeData.amount)) {
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
    _regularPriceController.dispose();
    _customPriceController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Room Entry', style: TextTheme.of(context).titleLarge),
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
                        widget.incomeData.nepaliDate,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  key: ValueKey(
                    'dropdown_${_customPriceController.text.isNotEmpty}_${_regularPriceController.text}',
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
      bottomNavigationBar: BlocConsumer<EditRoomEntryBloc, EditRoomEntryState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (failure) {
              CustomToast.showError(failure.message);
            },
            loaded: (data) {
              CustomToast.showSuccess('Room entry updated successfully');
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

                    final roomEntryModel = RoomEntryModel(
                      fixedPrice: parsedFixedPrice,
                      customPrice: _customPriceController.text,
                      additionalNotes: _additionalNotesController.text,
                      nepaliDate: widget.incomeData.nepaliDate,
                    );

                    context.read<EditRoomEntryBloc>().add(
                      EditRoomEntryEvent.editRoomEntry(
                        widget.incomeData.id,
                        roomEntryModel,
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
