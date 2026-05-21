import 'package:loggo/loggo.dart';

part 'loggo_example.loggo.dart';

void main() {
  Logger.targets['console'] = ConsoleLogTarget(
    includeDate: true,
    includeTime: true,
  );

  Logger.rules = [
    LogRule(
      expressions: [RegExp(r'.*ExampleService$')],
      minLevel: LogLevel.info,
      targetNames: ['console'],
    ),
  ];

  final service = ExampleService();
  service.run();
}

@Loggo()
class ExampleService {
  void run() {
    _logger.info('Example log from loggo');
  }
}
