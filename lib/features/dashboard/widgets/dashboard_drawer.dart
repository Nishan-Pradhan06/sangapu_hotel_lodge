import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../routers/app_routes_names.dart';
import '../../auth/cubits/logout/logout_cubit.dart';
import '../../auth/cubits/profile/profile_cubit.dart';
import '../../auth/models/user_profile_model.dart';
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
                context.read<ProfileCubit>().reset();
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(AppRoutesName.profilePage);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded: (profile) =>
                          _buildProfileDrawerHeader(context, profile),
                      loading: () => _buildLoadingDrawerHeader(context),
                      orElse: () => _buildDefaultDrawerHeader(context),
                    );
                  },
                ),
              ),
            ),
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
              title: Text(
                'Check for Updates',
                style: TextTheme.of(context).titleSmall,
              ),
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
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDrawerHeader(
    BuildContext context,
    UserProfileModel profile,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: colorScheme.primary,
          child: Text(
            profile.initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.displayName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                profile.email,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, size: 20),
      ],
    );
  }

  Widget _buildDefaultDrawerHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset(
              'assets/logo/logo.png',
              height: 52,
              width: 52,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sangapu Lodge',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tap to view profile',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, size: 20),
      ],
    );
  }

  Widget _buildLoadingDrawerHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: colorScheme.surfaceContainerHighest,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 100,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 10,
                width: 140,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
