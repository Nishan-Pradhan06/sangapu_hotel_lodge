import 'package:flutter_test/flutter_test.dart';
import 'package:sangapu/core/constant/app_constants.dart';

void main() {
  test('AppConstants privacy policy URL is valid and https', () {
    expect(AppConstants.privacyPolicyUrl, isNotEmpty);
    final uri = Uri.tryParse(AppConstants.privacyPolicyUrl);
    expect(uri, isNotNull);
    expect(uri!.hasScheme, isTrue);
    expect(uri.scheme, 'https');
    expect(uri.host, 'sangapu.com');
  });

  test('AppConstants terms of service URL is valid and https', () {
    expect(AppConstants.termsOfServiceUrl, isNotEmpty);
    final uri = Uri.tryParse(AppConstants.termsOfServiceUrl);
    expect(uri, isNotNull);
    expect(uri!.hasScheme, isTrue);
    expect(uri.scheme, 'https');
  });
}
