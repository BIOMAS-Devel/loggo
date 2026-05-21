import 'package:intl/intl.dart';

import 'log_level.dart';
import 'log_target.dart';

class ConsoleLogTarget extends LogTarget {
  final bool _includeDate;
  final bool _includeTime;

  ConsoleLogTarget({bool? includeDate, bool? includeTime})
    : _includeDate = includeDate ?? false,
      _includeTime = includeTime ?? false;

  @override
  void log(
    String loggerId,
    String loggerName,
    String runtimeTypeName,
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final now = DateTime.now();
    final prefix =
        "[${_getDatePrefix(now)}${_getTimePrefix(now)}${level.name.toUpperCase()}] [$loggerName:$runtimeTypeName:$loggerId]";
    print("$prefix $message");
    if (error != null) print("Error: $error");
    if (stackTrace != null) print("Stack: $stackTrace");
  }

  String _getDatePrefix(DateTime now) {
    if (!_includeDate) {
      return "";
    }

    final dateFormat = DateFormat('yyyy/MM/dd ');
    final formatted = dateFormat.format(now);
    return formatted;
  }

  String _getTimePrefix(DateTime now) {
    if (!_includeTime) {
      return "";
    }

    final dateFormat = DateFormat('HH:mm:ss.mmm ');
    final formatted = dateFormat.format(now);
    return formatted;
  }
}
