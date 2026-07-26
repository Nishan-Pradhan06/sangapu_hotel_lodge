import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  const CustomBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6,
      color: Theme.of(context).colorScheme.surface,
    );
  }
}
