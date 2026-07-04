import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../rooms/blocs/room_entry/room_entry_bloc.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final _formKey = GlobalKey<FormState>();

  final _expensesTypeController = TextEditingController();
  final _otherExpensesTypeController = TextEditingController();
  final _remarkController = TextEditingController();

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
                    'dropdown_${_otherExpensesTypeController.text.isNotEmpty}_${_expensesTypeController.text}',
                  ),
                  label: 'Expense Type',
                  type: CustomTextFieldType.dropdown,
                  controller: _expensesTypeController,
                  enabled: _otherExpensesTypeController.text.isEmpty,
                  dropdownItems: const [
                    'Select a Expense Type',
                    'Electricity Bill',
                    'Staff Salary',
                    'Water Bill',
                    'Maintenance',
                  ],
                  hint: 'Select a Expense Type',
                  onDropdownChanged: (value) {
                    if (value != 'Select a Expense Type' && value != null) {
                      _otherExpensesTypeController.clear();
                      setState(() {});
                    }
                  },
                ),
                CustomTextField(
                  controller: _otherExpensesTypeController,
                  label: 'Other Expense Type',
                  hint: 'Sapati, Internet, etc.',
                  type: CustomTextFieldType.text,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _expensesTypeController.text = 'Select a Expense Type';
                    }
                    setState(() {});
                  },
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
      //   bottomNavigationBar: BlocConsumer<RoomEntryBloc, RoomEntryState>(
      //     listener: (context, state) {
      //       state.whenOrNull(
      //         failure: (failure) {
      //           CustomToast.showError(failure.message);
      //         },
      //         loaded: (data) {
      //           CustomToast.showSuccess("Add Expenses Successfully");
      //           context.read<StatementsBloc>().add(
      //             const StatementsEvent.getStatement(),
      //           );
      //           context.pop();
      //         },
      //       );
      //     },
      //     builder: (context, state) {
      //       final bool isLoading = state.maybeWhen(
      //         loading: () => true,
      //         orElse: () => false,
      //       );
      //       return CustomPadding(
      //         child: SizedBox(
      //           height: MediaQuery.heightOf(context) / 14,
      //           child: CustomButton(
      //             isLoading: isLoading,
      //             isDisabled: isLoading,
      //             text: 'Save',
      //             onPressed: () {
      //               if (_formKey.currentState!.validate()) {
      //                 int? parsedFixedPrice;
      //                 if (_regularPriceController.text !=
      //                         'Select a standard rate' &&
      //                     _regularPriceController.text.isNotEmpty) {
      //                   final match = RegExp(
      //                     r'\d+',
      //                   ).firstMatch(_regularPriceController.text);
      //                   if (match != null) {
      //                     parsedFixedPrice = int.tryParse(match.group(0)!);
      //                   }
      //                 }

      //                 final roomEntryModel = RoomEntryModel(
      //                   fixedPrice: parsedFixedPrice,
      //                   customPrice: _customPriceController.text,
      //                   additionalNotes: _additionalNotesController.text,
      //                   nepaliDate: DateHelper.nepaliDate(),
      //                 );
      //                 context.read<RoomEntryBloc>().add(
      //                   RoomEntryEvent.roomEntry(roomEntryModel),
      //                 );
      //               }
      //             },
      //           ),
      //         ),
      //       );
      //     },
      //   ),
    );
  }
}
