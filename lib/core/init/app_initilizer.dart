import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import '../config/env_config.dart';
import '../di/dependency_injection.dart';
import '../services/cache_policy_service.dart';
import '../services/cache_service.dart';

class AppInitializer {
  static Future<void> init({GoRouter? router}) async {
    // Enable edge-to-edge mode and transparent system bars for Android 15+ & backward compatibility
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    // Load .env
    await dotenv.load(fileName: '.env');

    EnvConfig.initialize(Environment.development);

    log(EnvConfig.instance.apiBaseUrl);

    // 1. Initialize cache store FIRST
    await initializeCache();

    // 2. Register global services (SharedPreferences, etc.)
    await CacheServices.instance.init();

    // 3. Register DI (Now DioClient can safely use initialized cacheOptions)
    await setupServiceLocator();
  }
}
