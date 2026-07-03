import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/features/auth/blocs/login/log_in_bloc.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../routers/app_routes_names.dart';
import '../models/login_model.dart';
import '../widgets/auth_header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: CustomPadding(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthHeaderWidget(
                    title: 'Log in to your Account',
                    subtitle: 'Welcome back! Please enter your details.',
                  ),
                  SizedBox(height: 10),

                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: _emailController,
                    borderColor: Colors.grey[300]!,
                    type: CustomTextFieldType.email,
                  ),

                  CustomTextField(
                    label: 'Password',
                    controller: _passwordController,
                    hint: 'Enter your password',
                    obscureText: true,
                    borderColor: Colors.grey[300]!,
                    type: CustomTextFieldType.password,
                  ),

                  BlocConsumer<LogInBloc, LogInState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        failure: (failure) {
                          CustomToast.showError(failure.message);
                        },
                        loaded: (data) {
                          context.goNamed(AppRoutesName.bottomNavRoutePage);
                          CustomToast.showSuccess(data);
                        },
                      );
                    },
                    builder: (context, state) {
                      final bool isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );
                      return CustomButton(
                        text: 'Login',
                        isLoading: isLoading,
                        isDisabled: isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LogInBloc>().add(
                              LogInEvent.login(
                                LogInModel(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
