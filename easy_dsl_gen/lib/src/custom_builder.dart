import 'package:build/build.dart';
import 'package:easy_dsl/easy_dsl.dart';
import 'package:source_gen/source_gen.dart';

import 'div_gen.dart';

class CustomBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.easy']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final outputId = buildStep.allowedOutputs.single;

    if (inputId.path.endsWith(".easy.g.dart")) {
      return;
    }

    final StringBuffer output = StringBuffer();

    // log.warning("build: ${inputId.path}, outputId: ${outputId.path}");

    final ele = await buildStep.resolver.libraryFor(buildStep.inputId);

    final allElements = [...ele.topLevelElements];
    // ...ele.parts,
    // ...ele.units,

    for (final element in allElements) {
      final ast = await buildStep.resolver.astNodeFor(element);
      if (ast == null) {
        continue;
      }

      final visitor = DivVisitor();
      ast.visitChildren(visitor);

      // 输出所有找到的 className 值
      for (var className in visitor.foundClassNames) {
        print(
          "[WARNING] ==================================== "
          "Found Div with className: $className",
        );

        output.writeln("// [className]: $className");
      }
    }

    final allElements2 = [
      ele,
      ...ele.topLevelElements,
      ...ele.libraryImports,
      ...ele.libraryExports,
      ...ele.parts,
    ];
    TypeChecker typeChecker = TypeChecker.fromRuntime(EasyDSL);

    for (final element in allElements2) {
      final anno = typeChecker.firstAnnotationOf(element);
      if (anno != null) {
        print("[WARNING] ==================================== "
            "uri: ${element.source?.uri} "
            "${anno}");

        output.writeln("// [element]: $element");
      }
    }

    await buildStep.writeAsString(outputId, output.toString());
  }
}
