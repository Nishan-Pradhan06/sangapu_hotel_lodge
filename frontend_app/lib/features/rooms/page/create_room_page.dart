import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/core/widgets/custom_button.dart';
import 'package:sangapu/core/widgets/custom_container.dart';
import 'package:sangapu/core/widgets/custom_padding.dart';
import 'package:sangapu/core/widgets/custom_text_form_field.dart';
import 'package:sangapu/features/rooms/blocs/room_entry/room_entry_bloc.dart';
import '../../../core/helpers/nepali_date_helper.dart';
import '../../../core/widgets/custom_toast.dart';
import '../models/room_entry_model.dart';

class CreateRoomEntryPage extends StatefulWidget {
  const CreateRoomEntryPage({super.key});

  @override
  State<CreateRoomEntryPage> createState() => _CreateRoomEntryPageState();
}

class _CreateRoomEntryPageState extends State<CreateRoomEntryPage> {
  final _formKey = GlobalKey<FormState>();

  final _regularPriceController = TextEditingController();
  final _customPriceController = TextEditingController();
  final _additionalNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Room Entry')),
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
                  label: 'Regular Price',
                  type: CustomTextFieldType.dropdown,
                  controller: _regularPriceController,
                  dropdownItems: [
                    'Select a standard rate',
                    'Rs. 800',
                    'Rs. 900',
                    'Rs. 1000',
                    'Rs. 1100',
                    'Rs. 1200',
                  ],
                  hint: 'Select a standard rate',
                ),
                CustomTextField(
                  controller: _customPriceController,
                  label: 'Enter Custom Amount',
                  hint: '0.00',
                  type: CustomTextFieldType.number,
                  keyboardType: TextInputType.numberWithOptions(),
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
      bottomNavigationBar: BlocConsumer<RoomEntryBloc, RoomEntryState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (failure) {
              CustomToast.showError(failure.message);
            },
            loaded: (data) {
              CustomToast.showSuccess("Room entry successful");
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
                    final roomEntryModel = RoomEntryModel(
                      fixedPrice: int.parse(_regularPriceController.text),
                      customPrice: _customPriceController.text,
                      additionalNotes: _additionalNotesController.text,
                      nepaliDate: DateHelper.nepaliDate(),
                    );
                    context.read<RoomEntryBloc>().add(
                      RoomEntryEvent.roomEntry(roomEntryModel),
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
