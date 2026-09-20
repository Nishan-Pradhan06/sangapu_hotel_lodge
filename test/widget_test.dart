import 'package:flutter_test/flutter_test.dart';
import 'package:sangapu/core/constant/app_constants.dart';

void main() {
  test('App smoke test: verifies core constants', () {
    expect(AppConstants.privacyPolicyUrl, contains('privacy-policy'));
  });
}
