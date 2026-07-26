import 'package:flutter/material.dart';

class LoginOptionsWidget extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgotPassword;

  const LoginOptionsWidget({
    super.key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                checkboxTheme: const CheckboxThemeData(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                ),
              ),
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
              ),
            ),
            const SizedBox(width: 5),
            const Text('Remember me'),
          ],
        ),
        TextButton(
          onPressed: onForgotPassword,
          child: const Text('Forgot password?'),
        ),
      ],
    );
  }
}
