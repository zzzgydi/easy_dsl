import 'package:build/build.dart';
import 'package:easy_dsl/easy_dsl.dart';
import 'package:source_gen/source_gen.dart';

import 'visitor.dart';

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
    final visitor = DivVisitor();

    await Future.wait(
      ele.topLevelElements.map((e) async {
        final ast = await buildStep.resolver.astNodeFor(e, resolve: true);
        if (ast == null) {
          return;
        }
        ast.visitChildren(visitor);
      }),
    );

    // 输出所有找到的 className 值
    for (var className in visitor.foundClassNames) {
      output.writeln("// [className]: $className");
    }

    final allElements = [
      ele,
      ...ele.topLevelElements,
      ...ele.libraryImports,
      ...ele.libraryExports,
      ...ele.parts,
    ];

    TypeChecker typeChecker = TypeChecker.fromRuntime(EasyDSL);

    for (final element in allElements) {
      final anno = typeChecker.firstAnnotationOf(element);
      if (anno != null) {
        output.writeln("// [element]: ${anno.type}");
      }
    }

    await buildStep.writeAsString(outputId, output.toString());
  }
}
