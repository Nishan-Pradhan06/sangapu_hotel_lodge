import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import '../config/env_config.dart';
import '../di/dependency_injection.dart';
import '../services/cache_policy_service.dart';
import '../services/cache_service.dart';

class AppInitializer {
  static Future<void> init({GoRouter? router}) async {
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
