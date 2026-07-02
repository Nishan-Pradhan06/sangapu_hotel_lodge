import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvSecreteConfig {
  static final EnvSecreteConfig instance = EnvSecreteConfig._();
  EnvSecreteConfig._();


  String get apiBaseUrl {
    final String? key = dotenv.env['API_BASE_URL'];
    if (key == null) {
      throw 'API_BASE_URL not found';
    }
    return key;
  }

  ///only base url without api at last
  // String get baseUrl {
  //   final String? key = dotenv.env['BASE_URL'];
  //   if (key == null) {
  //     throw 'API_BASE_URL not found';
  //   }
  //   return key;
  // }

  // String get apiTestBaseUrl {
  //   final String? key = dotenv.env['API_TEST_BASE_URL'];
  //   if (key == null) {
  //     throw 'API_BASE_URL not found';
  //   }
  //   return key;
  // }

  // String get baseTestUrl {
  //   final String? key = dotenv.env['BASE_TEST_URL'];
  //   if (key == null) {
  //     throw 'BASE_Test_URL not found';
  //   }
  //   return key;
  // }
}
