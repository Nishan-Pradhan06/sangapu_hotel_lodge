import 'env_secrete_config.dart';

enum Environment { development, production }

class EnvConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;

  EnvConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
  });

  factory EnvConfig.development() {
    return EnvConfig(
      apiBaseUrl: EnvSecreteConfig.instance.apiBaseUrl,
      environment: Environment.development,
      enableLogging: true,
    );
  }

  factory EnvConfig.production() {
    return EnvConfig(
      apiBaseUrl: EnvSecreteConfig.instance.apiBaseUrl,
      environment: Environment.production,
      enableLogging: false,
    );
  }

  static late EnvConfig _instance;

  static void initialize(Environment env) {
    switch (env) {
      case Environment.development:
        _instance = EnvConfig.development();
        break;
      case Environment.production:
        _instance = EnvConfig.production();
        break;
    }
  }

  static EnvConfig get instance => _instance;
}
