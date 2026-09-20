import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../routers/app_routes_names.dart';
import '../../auth/cubits/logout/logout_cubit.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  void _showLogoutDialog(BuildContext context) {
    final logoutCubit = context.read<LogoutCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (context.mounted) {
                Navigator.pop(context);
              }
              logoutCubit.logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Sangapu',
      applicationVersion: '1.0.0',
      applicationIcon: Image.asset(
        'assets/logo/logo.png',
        height: 50,
        width: 50,
      ),

      children: [
        const SizedBox(height: 16),
        const Text(
          'Sangapu is an internal hotel and lodge ledger management application designed to track room stays, beverage sales, and daily operational expenses.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo/logo.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text('Home', style: TextTheme.of(context).titleSmall),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy', style: TextTheme.of(context).titleSmall),
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.openPrivacyPolicy();
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text('Terms of Service', style: TextTheme.of(context).titleSmall),
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.openTermsOfService();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('About App', style: TextTheme.of(context).titleSmall),
              onTap: () {
                _showAboutDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
              title: Text('Account Deletion', style: TextTheme.of(context).titleSmall),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(AppRoutesName.deleteAccount);
              },
            ),

            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_outlined, color: Colors.red),
              title: Text(
                'Logout',
                style: TextTheme.of(context).titleSmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
