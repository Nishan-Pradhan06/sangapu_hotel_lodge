import 'package:logger/logger.dart';
import '../core/config/env_config.dart';

Logger dLog = Logger(
  level: EnvConfig.instance.enableLogging ? Level.debug : Level.off,
  output: EnvConfig.instance.enableLogging ? null : SilentOutPut(),
);

class SilentOutPut extends LogOutput {
  @override
  void output(OutputEvent event) {}
}
