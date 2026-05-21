import 'package:loggo/loggo.dart';
import 'package:test/test.dart';

void main() {
  test('logger routes messages to matching targets', () {
    final target = _MemoryTarget();

    Logger.targets = {'memory': target};
    Logger.rules = [
      LogRule(
        expressions: [RegExp(r'.*service.*', caseSensitive: false)],
        minLevel: LogLevel.info,
        targetNames: ['memory'],
      ),
    ];

    final logger = Logger(
      id: 'abcde',
      name: 'my_service',
      runtimeTypeName: 'MyService',
    );

    logger.info('hello');

    expect(target.messages, ['hello']);
  });
}

class _MemoryTarget extends LogTarget {
  final messages = <String>[];

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
    messages.add(message);
  }
}
