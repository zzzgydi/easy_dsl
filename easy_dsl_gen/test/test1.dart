import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

void main() {
  // 替换为你的 Dart 文件路径
  var code = '''class HomePage extends StatelessWidget {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
      var div = Div(className: "flex items-center hhh", children: [
        Text('He'),
      ]);

      return Container(
        child: Column(
          children: [
            Text('Hello'),
            Div(
              className: "block items-center", children: [
              const Div(
                className: "flex inline items-center",
                children: [Text("test")],
              ),
            ])
          ],
        ),
      );
    }
  }

  class HomePage2 extends StatelessWidget {
    const HomePage2({super.key});

    @override
    Widget build(BuildContext context) {
      return const Column(
        children: [
          // Text('Hello'),

          Div(className: "flex items-center222", children: [
            Text('He'),
          ])
        ],
      );
    }
  }

  class TestDemo extends StatelessWidget {
    const TestDemo({super.key});

    @override
    Widget build(BuildContext context) {
      return const Div(
        className: "flex items-center",
        children: [Text("test")],
      );
    }
  }''';

  // 解析 Dart 代码
  var result = parseString(
      content: code, featureSet: FeatureSet.latestLanguageVersion());

  // print(result.unit);
  // 访问 AST
  var visitor = CustomVisitor();
  result.unit.visitChildren(visitor);

  // 输出所有找到的 className 值
  for (var className in visitor.foundClassNames) {
    print("result: $className");
  }
}

class CustomVisitor extends GeneralizingAstVisitor<void> {
  final foundClassNames = <String>[];

  @override
  void visitNode(AstNode node) {
    print("visitNode: ${node.runtimeType.toString()} ${node.toSource()}");

    if (node is InstanceCreationExpression) {
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

    if (node is MethodInvocation) {
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

    // 继续遍历 AST
    super.visitNode(node);
  }
}

class DivVisitor extends RecursiveAstVisitor<void> {
  final foundClassNames = <String>[];

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    print(node.constructorName.type.toSource());

    if (node.constructorName.type.toSource() == 'Div') {
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
    print("Invocation: ${node.runtimeType.toString()} ${node.methodName}");

    if (node.methodName.toString() == 'Div') {
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

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    print(
        "FunctionExpressionInvocation: ${node.runtimeType.toString()} ${node.function}");
    super.visitFunctionExpressionInvocation(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    print("FunctionDeclaration: ${node.runtimeType.toString()} ${node.name}");
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    print(
        "TopLevelVariableDeclaration: ${node.runtimeType.toString()} ${node.variables.variables}");
    super.visitTopLevelVariableDeclaration(node);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    print(
        "CompilationUnit: ${node.runtimeType.toString()} ${node.declarations}");
    super.visitCompilationUnit(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    print("ClassDeclaration: ${node.runtimeType.toString()} ${node.name}");
    super.visitClassDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    print("FieldDeclaration: ${node.runtimeType.toString()} ${node.fields}");
    super.visitFieldDeclaration(node);
  }

  // @override
  // void visitConstantConstructorInvocation() {
  //   print("ConstantConstructorInvocation");
  //   super.visitConstantConstructorInvocation();
  // }

  // @override
  // void visitNamedExpression(NamedExpression node) {
  //   print("NamedExpression: ${node.runtimeType.toString()} ${node.name}");
  //   super.visitNamedExpression(node);
  // }

  // @override
  // void visitVariableDeclaration(VariableDeclaration node) {
  //   print("VariableDeclaration: ${node.runtimeType.toString()} ${node.name}");
  //   super.visitVariableDeclaration(node);
  // }
}
