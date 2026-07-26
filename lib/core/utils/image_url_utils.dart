import '../config/env_config.dart';

class ImageUrlUtils {
  static String getImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';

    // Sanitize the URL: remove log junk, newlines, and extra whitespace
    String cleanUrl = url.replaceAll(RegExp(r'[\r\n]'), '').trim();
    if (cleanUrl.contains('║')) {
      cleanUrl = cleanUrl.split('║').last.trim();
    }
    // Remove common log prefixes if they somehow got in
    cleanUrl = cleanUrl.replaceAll(RegExp(r'I/flutter \(\d+\):'), '').trim();

    if (cleanUrl.startsWith('http')) return cleanUrl;

    String baseUrl = EnvConfig.instance.apiBaseUrl;

    // Remove trailing slash if present
    if (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    // Ensure url starts with a single slash
    if (url.startsWith('/')) {
      return '$baseUrl$url';
    } else {
      return '$baseUrl/$url';
    }
  }
}
