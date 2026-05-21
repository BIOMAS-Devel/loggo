import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'logger_generator.dart';

Builder loggerBuilderFactory(BuilderOptions options) =>
    PartBuilder([LoggerGenerator()], '.loggo.dart');
