import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/combine_gen.dart';
import 'src/custom_builder.dart';
import 'src/custom_combine_builder.dart';
import 'src/div_gen.dart';
import 'src/lib_gen.dart';

Builder easyBuilder(BuilderOptions options) => LibraryBuilder(
      DivUsageGenerator(),
      generatedExtension: '.easy.g.part',
    );

Builder combineBuilder(BuilderOptions options) =>
    LibraryBuilder(CombineGenerator());

Builder customBuilder(BuilderOptions options) => CustomBuilder();

Builder customCombineBuilder(BuilderOptions options) => CustomCombineBuilder();

PostProcessBuilder customCleanup(BuilderOptions options) =>
    FileDeletingBuilder(['.easy']);
