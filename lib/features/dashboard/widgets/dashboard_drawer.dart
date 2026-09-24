import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../routers/app_routes_names.dart';
import '../../auth/cubits/logout/logout_cubit.dart';
import '../../app_update/services/app_update_manager.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  String _appVersion = '2.1.10';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = '${info.version}+${info.buildNumber}';
        });
      }
    } catch (_) {}
  }

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
      applicationVersion: _appVersion,
      applicationIcon: Image.asset(
        'assets/logo/logo.png',
        height: 50,
        width: 50,
      ),

      children: [
        const SizedBox(height: 16),
        const Text(
          'Sangapu is a simple tool to record your daily income and expenses. Keep track of everyday entries, and export clean reports in PDF or Excel.',
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
              title: Text(
                'Privacy Policy',
                style: TextTheme.of(context).titleSmall,
              ),
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.openPrivacyPolicy();
              },
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(
                'Terms and Conditions',
                style: TextTheme.of(context).titleSmall,
              ),
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.openTermsAndConditions();
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
              leading: const Icon(Icons.system_update_rounded),
              title: Text('Check for Updates', style: TextTheme.of(context).titleSmall),
              subtitle: Text(
                'v$_appVersion',
                style: TextTheme.of(context).bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.chevron_right_rounded, size: 20),
              onTap: () {
                Navigator.pop(context);
                AppUpdateManager.checkAppUpdate(context, isManual: true);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
              ),
              title: Text(
                'Account Deletion',
                style: TextTheme.of(context).titleSmall,
              ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Version $_appVersion',
                style: TextTheme.of(context).bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
