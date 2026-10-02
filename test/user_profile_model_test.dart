import 'package:flutter_test/flutter_test.dart';
import 'package:sangapu/features/auth/models/user_profile_model.dart';

void main() {
  group('UserProfileModel Test', () {
    test('Correctly parses JSON response from GET /api/auth/profile/', () {
      final json = {
        "id": 1,
        "email": "user@example.com",
        "name": "Sangapu Lodge",
        "username": "sangapu_lodge",
        "date_joined": "2026-10-02T07:38:46.962Z",
      };

      final profile = UserProfileModel.fromJson(json);

      expect(profile.id, 1);
      expect(profile.email, 'user@example.com');
      expect(profile.name, 'Sangapu Lodge');
      expect(profile.username, 'sangapu_lodge');
      expect(profile.dateJoined, isNotNull);
      expect(profile.displayName, 'Sangapu Lodge');
      expect(profile.initials, 'SL');
      expect(profile.formattedDateJoined, '02 Oct 2026');

      final serialized = profile.toJson();
      expect(serialized['id'], 1);
      expect(serialized['email'], 'user@example.com');
      expect(serialized['name'], 'Sangapu Lodge');
      expect(serialized['username'], 'sangapu_lodge');
    });

    test('Gracefully handles missing or empty optional fields', () {
      final json = <String, dynamic>{
        "id": 0,
        "email": "single@example.com",
      };

      final profile = UserProfileModel.fromJson(json);

      expect(profile.id, 0);
      expect(profile.email, 'single@example.com');
      expect(profile.name, '');
      expect(profile.username, '');
      expect(profile.dateJoined, isNull);
      expect(profile.displayName, 'single');
      expect(profile.initials, 'SI');
      expect(profile.formattedDateJoined, 'N/A');
    });
  });
}
