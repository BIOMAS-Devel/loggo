import 'dart:async';
import 'dart:math';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'annotations.dart';

class LoggerGenerator extends GeneratorForAnnotation<Loggo> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return "";

    final package = buildStep.inputId.package;

    final pathWithExtension = buildStep.inputId.path;
    final pathWithoutExtension = pathWithExtension.replaceAll(
      RegExp(r'\.dart$'),
      '',
    );

    final className = element.name;

    final loggerName = "$package:$pathWithoutExtension:$className";
    final loggerId = _generateId();

    return '''
extension _\$${className}LoggerExtension on $className {
  static final _loggers = Expando<Logger>();

  Logger get _logger =>
      _loggers[this] ??= Logger(
        id: '$loggerId', 
        name: '$loggerName', 
        runtimeTypeName: runtimeType.toString(),
      );
}
''';
  }

  String _generateId() {
    const lettere = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    return List.generate(
      5,
      (_) => lettere[random.nextInt(lettere.length)],
    ).join();
  }
}
