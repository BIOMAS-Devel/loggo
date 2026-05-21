part of 'loggo_example.dart';

extension _$ExampleServiceLoggerExtension on ExampleService {
  static final _loggers = Expando<Logger>();

  Logger get _logger =>
      _loggers[this] ??= Logger(
        id: 'example',
        name: 'loggo:example/loggo_example:ExampleService',
        runtimeTypeName: runtimeType.toString(),
      );
}
