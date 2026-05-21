import 'log_level.dart';

class LogRule {
  final List<RegExp> expressions;
  final LogLevel minLevel;
  final List<String> targetNames;

  LogRule({
    required this.expressions,
    required this.minLevel,
    required this.targetNames,
  });
}
