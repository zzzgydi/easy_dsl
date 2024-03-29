import 'package:build/build.dart';
import 'package:glob/glob.dart';

import '../generator/cls_generator.dart';
import '../generator/cls_item.dart';

class EasyCombineBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.easy': ['.easy.g.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    final outputId = buildStep.allowedOutputs.single;

    var contents = await buildStep.readAsString(inputId);

    if (!contents.contains("// [element]: EasyDSL")) {
      return;
    }

    log.warning(
        "[Easy Combine] build: ${inputId.path}, outputId: ${outputId.path}");

    final assetIds = await buildStep.findAssets(Glob("**/*.easy")).toList()
      ..sort();

    final clsSet = <String>{};

    await Future.wait(
      assetIds.map((e) async {
        final content = await buildStep.readAsString(e);
        final classNames = _getClassNames(content);
        clsSet.addAll(classNames);
      }),
    );

    final items = clsSet.map((e) => ClsItem.fromSrc(e)).toList();

    final generator = ClsGenerator(
      partOfUri: inputId.changeExtension('.dart').uri.toString(),
      items: items,
    );

    await buildStep.writeAsString(outputId, generator.generate());
  }

  List<String> _getClassNames(String content) {
    final lines = content.split("\n");
    return lines
        .map((e) => e.trim())
        .where((e) => e.startsWith("// [className]:"))
        .map((e) => e.replaceFirst("// [className]:", "").trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
