import 'package:url_launcher/url_launcher.dart';
import '../constant/app_constants.dart';
import '../widgets/custom_toast.dart';

class UrlLauncherHelper {
  /// Opens the given [url]. Defaults to opening in an external browser.
  static Future<bool> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        CustomToast.showError('Could not launch: $url');
        return false;
      }
    } catch (e) {
      CustomToast.showError('Unable to open link');
      return false;
    }
  }

  /// Opens the official Privacy Policy URL.
  static Future<bool> openPrivacyPolicy() {
    return openUrl(AppConstants.privacyPolicyUrl);
  }

  /// Opens the Terms of Service URL.
  static Future<bool> openTermsAndConditions() {
    return openUrl(AppConstants.termsAndConditionsUrl);
  }

  /// Opens the official Account & Data Deletion URL.
  static Future<bool> openAccountDeletion() {
    return openUrl(AppConstants.accountDeletionUrl);
  }

  /// Opens the app page on Google Play Store with market:// scheme or web URL fallback.
  static Future<bool> openPlayStore([String? customUrl]) async {
    try {
      final marketUri = Uri.parse('market://details?id=com.nishan.sangapu');
      if (await canLaunchUrl(marketUri)) {
        return await launchUrl(marketUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
    return openUrl(
      customUrl ?? 'https://play.google.com/store/apps/details?id=com.nishan.sangapu',
    );
  }
}
