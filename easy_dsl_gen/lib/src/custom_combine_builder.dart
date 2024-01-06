import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

class CustomCombineBuilder implements Builder {
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

    if (!contents.contains("// [element]:")) {
      return;
    }

    // final pattern = buildStep.inputId.changeExtension('*.easy').path;

    final assetIds = await buildStep.findAssets(Glob("**/*.easy")).toList()
      ..sort();

    log.warning("[Combine] build: ${inputId.path}, outputId: ${outputId.path}, "
        "assets: ${assetIds.map((e) => e.path).join("\n")}");

    // log.info("\n$contents");

    // Write out the new asset.
    await buildStep.writeAsString(outputId, contents);
  }
}
