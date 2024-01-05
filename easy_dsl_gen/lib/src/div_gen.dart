import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

class DivUsageGenerator2 extends Generator {
  @override
  Future<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final StringBuffer output = StringBuffer();

    print("source: ${library.element.source.uri}");
    final code = library.element.source.contents.data;

    // print("code: $code");
    // 解析 Dart 代码
    final result = parseString(
        content: code, featureSet: FeatureSet.latestLanguageVersion());
    var visitor = DivVisitor();
    result.unit.visitChildren(visitor);

    // 输出所有找到的 className 值
    for (var className in visitor.foundClassNames) {
      print(
        "[WARNING] ==================================== Found Div with className: $className",
      );
    }
    return output.toString();
  }
}

class DivVisitor extends RecursiveAstVisitor<void> {
  final foundClassNames = <String>[];

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final nodeName = node.constructorName.type.toSource();

    print(
      "[WARNING] ==================================== Creation: $nodeName",
    );

    if (nodeName == 'Div') {
      var arguments = node.argumentList.arguments;
      for (var arg in arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'className') {
          var value = arg.expression;
          if (value is StringLiteral) {
            foundClassNames.add(value.stringValue!);
          }
        }
      }
    }
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final nodeName = node.methodName.toString();
    print(
      "[WARNING] ==================================== MethodInvocation: $nodeName",
    );

    if (nodeName == 'Div') {
      var arguments = node.argumentList.arguments;
      for (var arg in arguments) {
        if (arg is NamedExpression && arg.name.label.name == 'className') {
          var value = arg.expression;
          if (value is StringLiteral) {
            foundClassNames.add(value.stringValue!);
          }
        }
      }
    }

    super.visitMethodInvocation(node);
  }
}
