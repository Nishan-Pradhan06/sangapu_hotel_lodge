import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../routers/app_router.dart';
import '../models/app_version_info.dart';
import '../repository/app_update_repository.dart';
import '../widgets/app_update_dialog.dart';
import '../widgets/checking_update_dialog.dart';
import '../widgets/up_to_date_dialog.dart';

class AppUpdateManager {
  static const String _lastUpdatePromptKey = 'last_update_prompt_timestamp';
  static const Duration _promptSnoozeDuration = Duration(hours: 24);

  /// Compares two semantic version strings (e.g. "2.1.11" vs "2.1.10").
  /// Returns 1 if v1 > v2, -1 if v1 < v2, and 0 if equal.
  static int compareVersions(String v1, String v2) {
    try {
      final cleanV1 = v1.split('+').first.trim();
      final cleanV2 = v2.split('+').first.trim();

      final parts1 = cleanV1.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      final parts2 = cleanV2.split('.').map((e) => int.tryParse(e) ?? 0).toList();

      final maxLength = parts1.length > parts2.length ? parts1.length : parts2.length;
      while (parts1.length < maxLength) {
        parts1.add(0);
      }
      while (parts2.length < maxLength) {
        parts2.add(0);
      }

      for (int i = 0; i < maxLength; i++) {
        if (parts1[i] > parts2[i]) return 1;
        if (parts1[i] < parts2[i]) return -1;
      }
      return 0;
    } catch (_) {
      return 0;
    }
  }

  /// Checks if an update is required or available.
  /// [isManual]: When true (e.g. user clicked "Check for Updates" in drawer),
  /// a visual "Checking for Updates" loading dialog is shown, followed by either
  /// the update prompt or an "Up to date" confirmation dialog.
  static Future<void> checkAppUpdate(
    BuildContext context, {
    bool isManual = false,
  }) async {
    final navContext = rootNavigatorKey.currentContext ?? context;
    bool isProgressShowing = false;

    if (isManual && navContext.mounted) {
      isProgressShowing = true;
      CheckingUpdateDialog.show(navContext);
    }

    try {
      final startTime = DateTime.now();
      final repository = sl<AppUpdateRepository>();
      final result = await repository.checkAppVersion();

      // Ensure loading indicator is visible for at least 600ms for smooth UX
      if (isManual) {
        final elapsed = DateTime.now().difference(startTime);
        if (elapsed < const Duration(milliseconds: 600)) {
          await Future.delayed(const Duration(milliseconds: 600) - elapsed);
        }
      }

      final activeContext = rootNavigatorKey.currentContext ?? context;
      if (isProgressShowing && activeContext.mounted) {
        CheckingUpdateDialog.hide(activeContext);
        isProgressShowing = false;
      }

      if (!activeContext.mounted) return;

      await result.fold(
        (failure) async {
          debugPrint('[AppUpdateManager] Failed to fetch version info: ${failure.message}');
          if (isManual && activeContext.mounted) {
            CustomToast.showError('Unable to check for updates. Please check your connection.');
          }
        },
        (versionInfo) async {
          final packageInfo = await PackageInfo.fromPlatform();
          final currentVersion = packageInfo.version;
          final currentBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

          final hasNewerVersion =
              compareVersions(versionInfo.latestVersion, currentVersion) > 0;
          final hasNewerBuild =
              versionInfo.latestBuildNumber > currentBuildNumber;

          final isUpdateAvailable = hasNewerVersion || hasNewerBuild;

          debugPrint(
            '[AppUpdateManager] Current App: $currentVersion+$currentBuildNumber | '
            'Server Latest: ${versionInfo.latestVersion}+${versionInfo.latestBuildNumber} | '
            'Update Available: $isUpdateAvailable | Force: ${versionInfo.forceUpdate}',
          );

          final isBelowMinVersion =
              compareVersions(versionInfo.minSupportedVersion, currentVersion) >
                  0;
          final isBelowMinBuild =
              versionInfo.minSupportedBuildNumber > currentBuildNumber;

          final isForceUpdate =
              versionInfo.forceUpdate || isBelowMinVersion || isBelowMinBuild;

          if (isUpdateAvailable) {
            final effectiveVersionInfo = AppVersionInfo(
              latestVersion: versionInfo.latestVersion,
              latestBuildNumber: versionInfo.latestBuildNumber,
              minSupportedVersion: versionInfo.minSupportedVersion,
              minSupportedBuildNumber: versionInfo.minSupportedBuildNumber,
              forceUpdate: isForceUpdate,
              title: versionInfo.title,
              releaseNotes: versionInfo.releaseNotes,
              playStoreUrl: versionInfo.playStoreUrl,
              directDownloadUrl: versionInfo.directDownloadUrl,
            );

            // Handle snooze logic for optional updates
            if (!isForceUpdate && !isManual) {
              final prefs = await SharedPreferences.getInstance();
              final lastPrompt = prefs.getInt(_lastUpdatePromptKey) ?? 0;
              final now = DateTime.now().millisecondsSinceEpoch;

              if (now - lastPrompt < _promptSnoozeDuration.inMilliseconds) {
                // User was already prompted within 24 hours
                return;
              }

              await prefs.setInt(_lastUpdatePromptKey, now);
            }

            if (activeContext.mounted) {
              AppUpdateDialog.show(
                activeContext,
                versionInfo: effectiveVersionInfo,
                currentVersion: currentVersion,
                currentBuildNumber: currentBuildNumber,
              );
            }
          } else {
            if (isManual && activeContext.mounted) {
              UpToDateDialog.show(
                activeContext,
                currentVersion: currentVersion,
                currentBuildNumber: currentBuildNumber,
              );
            }
          }
        },
      );
    } catch (e, stack) {
      debugPrint('[AppUpdateManager] Exception during update check: $e\n$stack');
      final activeContext = rootNavigatorKey.currentContext ?? context;
      if (isProgressShowing && activeContext.mounted) {
        CheckingUpdateDialog.hide(activeContext);
      }
      if (isManual && activeContext.mounted) {
        CustomToast.showError('Error checking for updates.');
      }
    }
  }
}
