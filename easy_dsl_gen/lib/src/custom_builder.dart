import 'package:build/build.dart';

/// A really simple [Builder], it just makes copies of .txt files!
class CustomBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.easy']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    var inputId = buildStep.inputId;

    final outputId = buildStep.allowedOutputs.single;
    log.warning("build: ${inputId.path}, outputId: ${outputId.path}");

    // final a = await buildStep.resolver.libraryFor(inputId);

    var contents = await buildStep.readAsString(inputId);

    // log.info("\n$contents");

    // Write out the new asset.
    await buildStep.writeAsString(outputId, contents);
  }
}

class CustomCombineBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.easy.g.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    var inputId = buildStep.inputId;

    final outputId = buildStep.allowedOutputs.single;
    log.warning("[Combine] build: ${inputId.path}, outputId: ${outputId.path}");

    var contents = await buildStep.readAsString(inputId);

    // log.info("\n$contents");

    // Write out the new asset.
    await buildStep.writeAsString(outputId, contents);
  }
}
