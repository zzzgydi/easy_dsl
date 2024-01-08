import 'package:build/build.dart';
import 'package:easy_dsl/annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../visitor/classname_visitor.dart';

class EasyPartBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.easy']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final outputId = buildStep.allowedOutputs.single;

    if (inputId.path.endsWith(".g.dart")) {
      return;
    }

    final StringBuffer output = StringBuffer();

    // log.warning("build: ${inputId.path}, outputId: ${outputId.path}");

    final ele = await buildStep.resolver.libraryFor(buildStep.inputId);
    final visitor = ClassNameVisitor(nodeName: "Div");

    await Future.wait(
      ele.topLevelElements.map((e) async {
        final ast = await buildStep.resolver.astNodeFor(e, resolve: true);
        if (ast == null) {
          return;
        }
        ast.visitChildren(visitor);
      }),
    );

    // Find all className constants
    for (var className in visitor.foundClassNames) {
      output.writeln("// [className]: $className");
    }

    /// Find the EasyDSL annotation
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
