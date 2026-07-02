import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnceCacheService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setOnGettingStartCache() async {
    await _prefs.setString('getting_start_completed', 'completed');
  }

  Future<String?> getOnGettingStartCache() async {
    final data = _prefs.getString('getting_start_completed');
    return data;
  }

  //   Future<void> setOnBoardingCache() async {
  //     await _prefs.setString('onboarding_completed', 'completed');
  //   }

  //   Future<String?> getOnBoardingCache() async {
  //     final data = _prefs.getString('onboarding_completed');
  //     return data;
  //   }

    // Theme
    Future<void> setThemeCache(ThemeMode mode) async {
      String modeString = 'system';
      if (mode == ThemeMode.light) modeString = 'light';
      if (mode == ThemeMode.dark) modeString = 'dark';
      await _prefs.setString('theme_mode', modeString);
    }

    Future<String?> getThemeCache() async {
      return _prefs.getString('theme_mode');
    }
}
