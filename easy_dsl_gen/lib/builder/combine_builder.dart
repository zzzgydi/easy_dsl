import 'package:build/build.dart';
import 'package:glob/glob.dart';

class EasyCombineBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.easy': ['.easy.g.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    final outputId = buildStep.allowedOutputs.single;

    log.warning("[Combine] build: ${inputId.path}, outputId: ${outputId.path}");

    var contents = await buildStep.readAsString(inputId);

    if (!contents.contains("// [element]: EasyDSL")) {
      return;
    }

    final assetIds = await buildStep.findAssets(Glob("**/*.easy")).toList()
      ..sort();

    final StringBuffer output = StringBuffer();
    for (var assetId in assetIds) {
      final content = await buildStep.readAsString(assetId);
      output.writeln(content);
    }

    await buildStep.writeAsString(outputId, output.toString());
  }
}
