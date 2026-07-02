import 'package:flutter/material.dart';
import 'package:sangapu/core/widgets/custom_button.dart';
import 'package:sangapu/core/widgets/custom_container.dart';
import 'package:sangapu/core/widgets/custom_padding.dart';
import 'package:sangapu/core/widgets/custom_text_form_field.dart';

class CreateRoomEntryPage extends StatefulWidget {
  const CreateRoomEntryPage({super.key});

  @override
  State<CreateRoomEntryPage> createState() => _CreateRoomEntryPageState();
}

class _CreateRoomEntryPageState extends State<CreateRoomEntryPage> {
  final _regularPriceController = TextEditingController(
    text: 'Select a standard rate',
  );
  final _customPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Room Entry')),
      body: SingleChildScrollView(
        child: CustomPadding(
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
                      'Wednesday, July 1, 2026',
                      style: TextTheme.of(context).titleLarge,
                    ),
                  ],
                ),
              ),
              CustomTextField(
                label: 'Regular Price',
                type: CustomTextFieldType.dropdown,
                controller: _regularPriceController,
                dropdownItems: [
                  'Rs. 800',
                  'Rs. 900',
                  'Rs. 1000',
                  'Rs. 1100',
                  'Rs. 1200',
                ],
              ),
              CustomTextField(
                controller: _customPriceController,
                label: 'Enter Custom Amount',
                type: CustomTextFieldType.number,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              CustomTextField(label: 'Additional Notes', maxLines: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomPadding(
        child: SizedBox(
          height: MediaQuery.heightOf(context) / 14,
          child: CustomButton(text: 'Save', onPressed: () {}),
        ),
      ),
    );
  }
}
