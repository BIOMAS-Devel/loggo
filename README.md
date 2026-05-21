# loggo

`loggo` is a lightweight logging package for Dart and Flutter that combines:

- runtime log routing through named targets and rules
- log levels from `trace` to `fatal`
- source generation with `@AutoLogger` to attach a logger to a class

## Features

- Register one or more `LogTarget` implementations.
- Route logs by class name pattern with `LogRule`.
- Print to console with `ConsoleLogTarget`.
- Generate a per-instance logger with `build_runner`.

## Getting started

Add the package and code generation tool:

```yaml
dependencies:
  loggo: ^0.0.1

dev_dependencies:
  build_runner: ^2.8.0
```

## Basic runtime setup

```dart
import 'package:loggo/loggo.dart';

void configureLogging() {
  Logger.targets['console'] = ConsoleLogTarget(
    includeDate: true,
    includeTime: true,
  );

  Logger.rules = [
    LogRule(
      expressions: [RegExp(r'.*')],
      minLevel: LogLevel.debug,
      targetNames: ['console'],
    ),
  ];
}
```

## Using `@AutoLogger`

Annotate the class, add a `part` directive, then run code generation.

```dart
import 'package:loggo/loggo.dart';

part 'user_service.loggo.dart';

@AutoLogger()
class UserService {
  void loadUser() {
    _logger.info('Loading user');
  }
}
```

Run:

```bash
dart run build_runner build
```

## Custom targets

```dart
import 'package:loggo/loggo.dart';

class MemoryTarget extends LogTarget {
  final entries = <String>[];

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
    entries.add('[${level.name}] $loggerName $message');
  }
}
```

## Notes before publishing

- If you want a high pub score, add a public repository URL to `pubspec.yaml`.
- Add a public `repository:` field in `pubspec.yaml` before publishing for a better pub score.
