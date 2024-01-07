import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class DivVisitor extends GeneralizingAstVisitor<void> {
  final foundClassNames = <String>[];

  @override
  void visitNode(AstNode node) {
    if (node is InstanceCreationExpression) {
      final nodeName = node.constructorName.type.toSource();
      _findDivAndClassName(nodeName, node.argumentList.arguments);
    } else if (node is MethodInvocation) {
      final nodeName = node.methodName.name;
      _findDivAndClassName(nodeName, node.argumentList.arguments);
    }

    super.visitNode(node);
  }

  void _findDivAndClassName(String nodeName, NodeList<Expression> arguments) {
    if (nodeName != 'Div') {
      return;
    }

    for (var arg in arguments) {
      if (arg is NamedExpression && arg.name.label.name == 'className') {
        var value = arg.expression;

        if (value is StringLiteral) {
          foundClassNames.add(value.stringValue!);
        } else if (value is SimpleIdentifier && value.inConstantContext) {
          if (value.staticElement is VariableElement) {
            var staticElement = value.staticElement as VariableElement;
            var constantValue = staticElement.computeConstantValue();
            var runtimeString = constantValue?.toStringValue();

            if (runtimeString != null) {
              foundClassNames.add(runtimeString);
            }
          }
        }
      }
    }
  }
}
