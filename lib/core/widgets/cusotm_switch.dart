import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 60,
    this.height = 30,
    this.activeColor = const Color(0xFF6B48FF),
    this.inactiveColor = const Color(0xFFCCCCCC),
    this.thumbColor = const Color(0xFFFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value ? activeColor : inactiveColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: height - 8,
            height: height - 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thumbColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
