import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_toast.dart';

final Uri termAndServices = Uri.parse(
  'https://play.google.com/store/apps/details?id=com.sainotech.digitalgurukul',
);

Future<void> urlLauncher(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    // if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
    throw Exception('Could not launch $url');
  }
}

Future<void> urlLauncherWithFallback(BuildContext context, Uri url) async {
  try {
    await urlLauncher(url);
  } catch (e) {
    log('Error launching URL: $e');
    if (context.mounted) {
      log(e.toString());
      CustomToast.showError(e.toString());
    }
  }
}
