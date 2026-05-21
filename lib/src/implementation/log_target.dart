import 'log_level.dart';

abstract class LogTarget {
  void log(
    String loggerId,
    String loggerName,
    String runtimeTypeName,
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  });
}
