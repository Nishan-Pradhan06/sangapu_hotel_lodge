// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/widgets/custom_button.dart';
// import '../../../core/widgets/custom_padding.dart';
// import '../../../core/widgets/custom_text_form_field.dart';
// import '../../../core/widgets/custom_toast.dart';
// import '../../../routers/app_routes_names.dart';
// import '../blocs/sign_up/sign_up_bloc.dart';
// import '../models/signup_model.dart';
// import '../widgets/auth_header_widget.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: CustomPadding(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 spacing: 20,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const AuthHeaderWidget(
//                     title: 'Sign up for an Account',
//                     subtitle: 'Please enter your details to create an account.',
//                   ),
//                   SizedBox(height: 10),
//                   CustomTextField(
//                     label: 'Full Name',
//                     hint: 'Enter your full name',
//                     controller: _nameController,
//                     borderColor: Colors.grey[300]!,
//                     type: CustomTextFieldType.text,
//                   ),

//                   CustomTextField(
//                     label: 'Email',
//                     hint: 'Enter your email',
//                     controller: _emailController,
//                     borderColor: Colors.grey[300]!,
//                     type: CustomTextFieldType.email,
//                   ),

//                   CustomTextField(
//                     label: 'Password',
//                     hint: 'Enter your password',
//                     controller: _passwordController,
//                     obscureText: true,
//                     borderColor: Colors.grey[300]!,
//                     type: CustomTextFieldType.password,
//                   ),

//                   BlocConsumer<SignUpBloc, SignUpState>(
//                     listener: (context, state) {
//                       state.whenOrNull(
//                         failure: (failure) {
//                           CustomToast.showError(failure.message);
//                         },
//                         loaded: (data) {
//                           context.pushNamed(
//                             AppRoutesName.verifyEmailScreenRoute,
//                             extra: _emailController.text.trim(),
//                           );
//                           CustomToast.showSuccess(data);
//                         },
//                       );
//                     },
//                     builder: (context, state) {
//                       final bool isLoading = state.maybeWhen(
//                         loading: () => true,
//                         orElse: () => false,
//                       );
//                       return CustomButton(
//                         text: 'Sign Up',
//                         isDisabled: isLoading,
//                         isLoading: isLoading,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             context.read<SignUpBloc>().add(
//                               SignUpEvent.signUp(
//                                 SignUpModel(
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                   name: _nameController.text,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       );
//                     },
//                   ),

//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Already have an account?'),
//                       TextButton(
//                         onPressed: () {
//                           context.pop();
//                         },
//                         child: Text('Log In'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
