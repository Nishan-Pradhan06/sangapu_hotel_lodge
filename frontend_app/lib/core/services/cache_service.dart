import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/logger.dart';
import '../widgets/custom_toast.dart';

class CacheServices {
  CacheServices._internal();
  static final CacheServices instance = CacheServices._internal();

  late final SharedPreferences _prefs;
  late final FlutterSecureStorage _secureStorage;

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

  Future<void> setAuthToken({required String access, required String refresh}) async {
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
      dLog.d('Error reading auth token: $e');
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

  /// Clears the stored user role from shared preferences
  Future<void> clearUserRole() async {
    try {
      await _prefs.remove('user_role');
      dLog.d('User role cleared');
    } catch (e) {
      dLog.d('Error deleting user role: $e');
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

  /// Clears all session-related cache (used during logout)
  Future<void> clearAll() async {
    await clearAuthToken();
    await clearUserRole();
    dLog.d('All cache cleared');
    CustomToast.showSuccess('Cleared');
  }
}
