import 'log_level.dart';
import 'log_rule.dart';
import 'log_target.dart';

class Logger {
  static Map<String, LogTarget> targets = {};
  static List<LogRule> rules = [];

  final String _id;
  final String _name;
  final String _runtimeTypeName;

  final Map<LogLevel, List<LogTarget>> _enabledTargets = {};

  Logger({
    required String id,
    required String name,
    required String runtimeTypeName,
  }) : _id = id,
       _name = name,
       _runtimeTypeName = runtimeTypeName;

  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final targetMap = _shouldLogBasedOnRule(level);
    for (final target in targetMap) {
      target.log(
        _id,
        _name,
        _runtimeTypeName,
        level,
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  List<LogTarget> _shouldLogBasedOnRule(LogLevel level) {
    if (!_enabledTargets.containsKey(level)) {
      _enabledTargets[level] = _getTargetsForLevel(level);
    }

    return _enabledTargets[level]!;
  }

  List<LogTarget> _getTargetsForLevel(LogLevel level) {
    final result = <LogTarget>[];

    for (var rule in rules) {
      for (var expression in rule.expressions) {
        if (expression.hasMatch(_name)) {
          if (Enum.compareByIndex(level, rule.minLevel) < 0) continue;

          for (var targetName in rule.targetNames) {
            final target = targets[targetName];
            if (target == null) continue;
            if (result.contains(target)) continue;
            result.add(target);
          }
        }
      }
    }

    return result;
  }

  void trace(String message) => log(LogLevel.trace, message);
  void debug(String message) => log(LogLevel.debug, message);
  void info(String message) => log(LogLevel.info, message);
  void warn(String message) => log(LogLevel.warn, message);
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}
