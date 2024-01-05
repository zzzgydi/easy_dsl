import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:analyzer/dart/analysis/session.dart';
// import 'package:analyzer/dart/analysis/results.dart';

/// Returns all [TopLevelVariableElement] members in [reader]'s library that
/// have a type of [num].
Iterable<TopLevelVariableElement> topLevelNumVariables(LibraryReader reader) =>
    reader.allElements.whereType<TopLevelVariableElement>().where(
          (element) =>
              element.type.isDartCoreNum ||
              element.type.isDartCoreInt ||
              element.type.isDartCoreDouble,
        );

class MemberCountLibraryGenerator extends Generator {
  @override
  String? generate(LibraryReader library, BuildStep buildStep) {
    print('Generating for ${library.element.source.uri}');
    print('buildStep ${buildStep}');

    final topLevelVarCount = topLevelNumVariables(library).length;

    if (topLevelVarCount == 0) {
      return null;
    }

    return '''
// Source library: ${library.element.source.uri}
const topLevelNumVarCount = $topLevelVarCount;
''';
  }
}

class DivWidgetUsageGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    // 使用 StringBuffer 来构建输出
    StringBuffer output = StringBuffer();

    // 遍历所有类元素
    for (var classElement in library.classes) {
      // 遍历类中的所有方法和属性
      for (var member in [...classElement.methods, ...classElement.fields]) {
        // 检查成员是否使用了 Div Widget
        if (_usesDivWidget(member)) {
          // 收集并格式化信息
          output.writeln('Div Widget used in ${member.name}');
        }
      }
    }

    return output.toString();
  }

  bool _usesDivWidget(Element member) {
    // 实现用于检测 Div Widget 使用的逻辑
    // 这可能需要更复杂的分析逻辑
    // ...

    print(
      '[WARNING] ==================================== '
      'Checking ${member.name}, ${member.displayName}, ${member is ClassElement}, ${member.children}',
    );

    return false; // 根据实际情况返回 true 或 false
  }
}

// Future<bool> _usesDivWidget(Element element, AnalysisSession session) async {
//   // 获取源文件的解析结果
//   var result = await session.getResolvedUnit(element.source!.fullName)
//       as ResolvedUnitResult;

//   if (result.state != ResultState.VALID) {
//     return false;
//   }

//   // 查找匹配的 AST 节点
//   var node = _findNode(result.unit, element);

//   // 创建并使用自定义访问者来检查源码
//   var visitor = _DivWidgetVisitor();
//   node?.visitChildren(visitor);

//   return visitor.foundDivWidget;
// }

// AstNode? _findNode(CompilationUnit unit, Element element) {
//   // 遍历 AST 节点来找到匹配的元素
//   // ...

//   return null; // 返回找到的节点或 null
// }

// class _DivWidgetVisitor extends RecursiveAstVisitor<void> {
//   bool foundDivWidget = false;

//   @override
//   void visitInstanceCreationExpression(InstanceCreationExpression node) {
//     if (node.constructorName.type.toString() == 'Div') {
//       foundDivWidget = true;
//     }

//     super.visitInstanceCreationExpression(node);
//   }
// }
