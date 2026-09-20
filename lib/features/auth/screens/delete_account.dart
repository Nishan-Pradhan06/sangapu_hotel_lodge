import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_padding.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../main.dart';
import '../../../routers/app_routes_names.dart';
import '../cubits/account_deletions/account_deletion_cubit.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isConfirmed = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _showConfirmDeleteDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Confirm Deletion'),
          ],
        ),
        content: const Text(
          'Are you absolutely sure you want to delete your account? '
          'All your personal data and active sessions will be permanently erased. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              final cubit = parentContext.read<AccountDeletionCubit>();
              final password = _passwordController.text.trim();
              cubit.deleteAccount(
                password: password.isNotEmpty ? password : null,
              );
            },
            child: const Text(
              'Permanently Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountDeletionCubit, AccountDeletionState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (failure) {
            CustomToast.showError(
              failure.message.isNotEmpty
                  ? failure.message
                  : 'Failed to delete account. Please try again.',
            );
          },
          loaded: (message) {
            CustomToast.showSuccess(message);
            context.goNamed(AppRoutesName.loginScreenRoute);
            RestartWidget.restartApp(context);
          },
        );
      },
      builder: (context, state) {
        final bool isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Account Deletion'),
            scrolledUnderElevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: CustomPadding(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Warning Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red.shade700,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Warning: Irreversible Action',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Deleting your account is permanent. Once completed, your profile and credentials will be removed immediately.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red.shade800,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Policy & Data Retention Summary Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What happens when you delete:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            _buildBulletItem(
                              icon: Icons.check_circle_outline,
                              color: Colors.red,
                              title: 'Personal Data Erased',
                              description:
                                  'Your email, password credentials, session tokens, and local cache will be permanently wiped.',
                            ),
                            const SizedBox(height: 10),
                            _buildBulletItem(
                              icon: Icons.receipt_long_outlined,
                              color: Colors.blueGrey,
                              title: 'Ledger Records & Retention',
                              description:
                                  'Operational transaction logs required for statutory hotel bookkeeping and tax compliance are retained securely for up to 90 days before final purge.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Password Verification
                      Text(
                        'Confirm Identity',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Enter your current password to authorize account deletion.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _passwordController,
                        hint: 'Enter your current password',
                        obscureText: true,
                        type: CustomTextFieldType.password,
                        borderColor: Colors.grey.shade300,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required to confirm deletion';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Confirmation Checkbox
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          setState(() {
                            _isConfirmed = !_isConfirmed;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _isConfirmed,
                                activeColor: Colors.red.shade700,
                                onChanged: (value) {
                                  setState(() {
                                    _isConfirmed = value ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    'I understand that my account and personal data will be permanently deleted and cannot be recovered.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Button
                      CustomButton(
                        text: 'Permanently Delete My Account',
                        backgroundColor: Colors.red.shade600,
                        leadingIcon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.white,
                        ),
                        isLoading: isLoading,
                        isDisabled: !_isConfirmed || isLoading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _showConfirmDeleteDialog(context);
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Web Deletion Fallback (Google Play Policy requirement)
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            UrlLauncherHelper.openAccountDeletion();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.open_in_browser_rounded,
                                  size: 16,
                                  color: Colors.grey.shade700,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Request deletion via web portal instead',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBulletItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
