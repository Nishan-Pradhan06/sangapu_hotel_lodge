import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/logger.dart';

class CacheServices {
  CacheServices._internal();
  static final CacheServices instance = CacheServices._internal();

  late final SharedPreferences _prefs;
  late final FlutterSecureStorage _secureStorage;

  static const String _keyRememberMe = 'remember_me';
  static const String _keySavedEmail = 'saved_email';
  static const String _keySavedPassword = 'saved_password';

  /// Initialize all storage backends.
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _secureStorage = const FlutterSecureStorage();
    } catch (e, stack) {
      dLog.d('CacheService init failed: $e\n$stack');
    }
  }

  // ===== Secure Storage methods =====

  Future<void> setAuthToken({
    required String access,
    required String refresh,
  }) async {
    try {
      await _secureStorage.write(key: 'token', value: access);
      await _secureStorage.write(key: 'refresh', value: refresh);
    } catch (e) {
      dLog.d('Error saving auth token: $e');
    }
  }

  Future<String?> getAuthToken() async {
    try {
      return await _secureStorage.read(key: 'token');
    } catch (e) {
      dLog.d('Error reading auth token: $e');
      return null;
    }
  }

  Future<String?> getAuthRefreshToken() async {
    try {
      return await _secureStorage.read(key: 'refresh');
    } catch (e) {
      dLog.d('Error reading auth refresh token: $e');
      return null;
    }
  }

  /// Clears the stored auth token from secure storage
  Future<void> clearAuthToken() async {
    try {
      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: 'refresh');
      dLog.d('Auth token cleared');
    } catch (e) {
      dLog.d('Error deleting auth token: $e');
    }
  }

  // ===== SharedPreferences methods =====

  Future<void> setUserRole(List<String> role) async {
    try {
      await _prefs.setString('user_role', role.toString());
    } catch (e) {
      dLog.d('Error saving user role: $e');
    }
  }

  Future<String?> getUserRole() async {
    try {
      return _prefs.getString('user_role') ?? 'CUSTOMER';
    } catch (e) {
      dLog.d('Error getting user role: $e');
      return 'CUSTOMER';
    }
  }

  /// Clears the stored user role from shared preferences
  Future<void> clearUserRole() async {
    try {
      await _prefs.remove('user_role');
      dLog.d('User role cleared');
    } catch (e) {
      dLog.d('Error deleting user role: $e');
    }
  }

  // ===== Remember Me Methods =====

  /// Save only the boolean state for the "Remember Me" toggle
  Future<void> setRememberMe(bool value) async {
    try {
      await _prefs.setBool(_keyRememberMe, value);
    } catch (e) {
      dLog.d('Error setting remember me: $e');
    }
  }

  /// Returns true if "Remember Me" is enabled
  bool getRememberMe() {
    try {
      return _prefs.getBool(_keyRememberMe) ?? false;
    } catch (e) {
      dLog.d('Error reading remember me flag: $e');
      return false;
    }
  }

  /// Load all remembered credentials
  Future<Map<String, String?>> getRememberedCredentials() async {
    try {
      final isRemembered = getRememberMe();
      if (!isRemembered) return {'email': null, 'password': null};

      final email = _prefs.getString(_keySavedEmail);
      final password = await _secureStorage.read(key: _keySavedPassword);

      return {'email': email, 'password': password};
    } catch (e) {
      dLog.d('Error reading remembered credentials: $e');
      return {'email': null, 'password': null};
    }
  }

  /// Save or clear credentials based on checkbox selection
  Future<void> saveCredentials({
    required bool rememberMe,
    required String email,
    required String password,
  }) async {
    try {
      await setRememberMe(rememberMe);

      if (rememberMe) {
        await _prefs.setString(_keySavedEmail, email);
        await _secureStorage.write(key: _keySavedPassword, value: password);
      } else {
        await _prefs.remove(_keySavedEmail);
        await _secureStorage.delete(key: _keySavedPassword);
      }
    } catch (e) {
      dLog.d('Error saving credentials: $e');
    }
  }

  /// Clears all session-related cache (used during logout)
  Future<void> clearAll() async {
    await clearAuthToken();
    await clearUserRole();
  }
}
