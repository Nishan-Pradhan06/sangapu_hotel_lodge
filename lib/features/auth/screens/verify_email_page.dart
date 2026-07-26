// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lunar_lms/routers/app_routes_names.dart';
// import 'package:pinput/pinput.dart';
// import '../../../core/helpers/validation_helpers.dart';
// import '../../../core/theme/app_theme.dart';
// import '../../../core/widgets/custom_button.dart';
// import '../../../core/widgets/custom_padding.dart';
// import '../../../core/widgets/custom_toast.dart';
// import '../blocs/verify_email/verify_email_bloc.dart';
// import '../models/verify_email_model.dart';
// import '../widgets/auth_header_widget.dart';

// class VerifyEmailPage extends StatefulWidget {
//   final String email;
//   const VerifyEmailPage({super.key, required this.email});

//   @override
//   State<VerifyEmailPage> createState() => _VerifyEmailPageState();
// }

// class _VerifyEmailPageState extends State<VerifyEmailPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _otpController = TextEditingController();

//   @override
//   void dispose() {
//     _otpController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: borderColor),
//       ),
//     );
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
//                     title: 'Verify Your Email',
//                     subtitle:
//                         'A verification link has been sent to your email. Please click the link to verify your account.',
//                   ),
//                   SizedBox(height: 10),

//                   Text(
//                     'Email: ${widget.email}',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),

//                   Pinput(
//                     length: 6,
//                     controller: _otpController,
//                     validator: InputValidator.validateOtp,
//                     focusedPinTheme: defaultPinTheme.copyWith(
//                       decoration: defaultPinTheme.decoration!.copyWith(
//                         border: Border.all(color: Colors.grey),
//                       ),
//                     ),
//                     submittedPinTheme: defaultPinTheme.copyWith(
//                       decoration: defaultPinTheme.decoration!.copyWith(
//                         color: fillColor,
//                         border: Border.all(color: Colors.grey),
//                       ),
//                     ),
//                     errorPinTheme: defaultPinTheme.copyWith(
//                       decoration: defaultPinTheme.decoration!.copyWith(
//                         border: Border.all(color: AppTheme.error),
//                       ),
//                     ),
//                   ),
//                   BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
//                     listener: (context, state) {
//                       state.whenOrNull(
//                         failure: (failure) {
//                           CustomToast.showError(failure.message);
//                         },
//                         loaded: (data) {
//                           context.goNamed(
//                             AppRoutesName.learnerBottomNavRoutePage,
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
//                         text: 'Verify Email',
//                         isDisabled: isLoading,
//                         isLoading: isLoading,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             context.read<VerifyEmailBloc>().add(
//                               VerifyEmailEvent.verifyEmail(
//                                 VerifyEmailModel(
//                                   email: widget.email,
//                                   otp: _otpController.text,
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
