import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sangapu/features/auth/blocs/login/log_in_bloc.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../routers/app_routes_names.dart';
import '../cubits/remember_me/remember_me_cubit.dart';
import '../models/login_model.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/remember_me_widget.dart';

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
  void initState() {
    super.initState();
    _initRememberMe();
  }

  /// Initialize Cubit state and pre-fill credentials if stored
  Future<void> _initRememberMe() async {
    final credentials = await context.read<RememberMeCubit>().loadRememberMe();
    if (credentials['email'] != null) {
      _emailController.text = credentials['email']!;
    }
    if (credentials['password'] != null) {
      _passwordController.text = credentials['password']!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: CustomPadding(
            child: Form(
              key: _formKey,
              child: BlocBuilder<RememberMeCubit, RememberMeState>(
                builder: (context, rememberMeState) {
                  final bool isChecked = rememberMeState.maybeWhen(
                    loaded: (isRemembered) => isRemembered,
                    orElse: () => false,
                  );

                  return Column(
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
                      // Remember Me Checkbox Row
                      RememberMeWidget(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          context.read<RememberMeCubit>().toggleRememberMe(
                            newValue ?? false,
                          );
                        },
                      ),
                      BlocConsumer<LogInBloc, LogInState>(
                          listener: (context, state) {
                            state.whenOrNull(
                              failure: (failure) {
                                CustomToast.showError(failure.message);
                              },
                              loaded: (data) {
                                context.read<RememberMeCubit>().handleLoginSuccess(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
