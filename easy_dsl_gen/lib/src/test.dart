import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';

class DivUsageGenerator extends Generator {
  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
    if (library.element.source.uri.toString().contains("main.dart")) {
      return null;
    }
    if (library.element.source.uri.toString().contains("div.dart")) {
      return null;
    }

    final StringBuffer output = StringBuffer();
    final AnalysisSession session = library.element.session;

    // 获取元素所在库的解析过的 AST
    final parsedLibrary = session.getParsedLibraryByElement(library.element)
        as ParsedLibraryResult;

    print(
      '[WARNING] ==================================== ${parsedLibrary.units}',
    );

    for (var element in library.allElements) {
      print('[WARNING] ==================================== '
          "element: ${element.name}");

      // print('[WARNING] ==================================== '
      //     "content: ${element.source?.contents.data}");

      for (var child in element.children) {
        print('[WARNING] ==================================== '
            "child: ${child.name}");
      }

      // 找到该元素的 AST 节点
      var node = _findElementNode(parsedLibrary, element);

      if (node != null) {
        var visitor = _DivWidgetVisitor();
        node.visitChildren(visitor);

        for (var className in visitor.classNames) {
          // output.writeln('Found Div with className: $className');
          print('[WARNING] ==================================== '
              'Found Div with className: $className');
        }
      }
    }

    return output.toString();
  }

  AstNode? _findElementNode(
      ParsedLibraryResult parsedLibrary, Element element) {
    var elementSource = element.source;
    if (elementSource == null) {
      return null;
    }

    var elementRange = SourceRange(element.nameOffset, element.nameLength);
    print(
      '[WARNING] ==================================== ${elementRange.toString()}',
    );

    for (var parsedUnit in parsedLibrary.units) {
      var unit = parsedUnit.unit;

      // print(
      //   '[WARNING--unit] ==================================== ${parsedUnit.content}',
      // );
      if (unit.declaredElement?.source != elementSource) {
        continue;
      }

      var node = _findNodeInRange(unit, elementRange);
      if (node != null) {
        return node;
      }
    }

    return null;
  }

  AstNode? _findNodeInRange(CompilationUnit unit, SourceRange range) {
    NodeLocator locator =
        NodeLocator(range.offset, range.offset + range.length);
    return locator.searchWithin(unit);
  }
}

class _DivWidgetVisitor extends RecursiveAstVisitor<void> {
  final List<String> classNames = [];

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.toSource() == 'Div') {
      var classNameArgument = node.argumentList.arguments.firstWhere(
        (arg) => arg is NamedExpression && arg.name.label.name == 'className',
      ) as NamedExpression;
      classNames.add(classNameArgument.expression.toString());
    }

    super.visitInstanceCreationExpression(node);
  }
}
