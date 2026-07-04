import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import '../config/env_config.dart';
import '../di/dependency_injection.dart';
import '../services/cache_service.dart';

class AppInitializer {
  static Future<void> init({GoRouter? router}) async {
    // Load .env
    await dotenv.load(fileName: '.env');

    EnvConfig.initialize(Environment.development);

    log(EnvConfig.instance.apiBaseUrl);

    await setupServiceLocator();

    //Global SharedPreferences
    await CacheServices.instance.init();
  }
}
