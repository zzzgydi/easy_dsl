import 'package:dart_style/dart_style.dart';

import 'cls_item.dart';
import 'widget_generator.dart';

class ClsGenerator {
  ClsGenerator({
    required this.items,
  });

  final List<ClsItem> items;

  final formatter = DartFormatter();

  String generate() {
    final taskMap = <String, List<ClsItem>>{};
    for (final item in items) {
      final hashCls = item.hashCls;
      if (taskMap.containsKey(hashCls)) {
        taskMap[hashCls]!.add(item);
      } else {
        taskMap[hashCls] = [item];
      }
    }

    final outMap = <String, String>{};
    List<String> widgetList = [];
    List<String> constructorList = [];

    var index = 1;
    taskMap.forEach((key, value) {
      final constructor = "\$DIV${index++}";
      final item = value.first;
      widgetList.add(WidgetGenerator(item, constructor).generate());
      constructorList.add(constructor);

      for (final item in value) {
        outMap[item.srcCls] = constructor;
      }
    });

    final widgetCode = widgetList.join("\n\n");

    return formatter.format(
        "$widgetCode\n\n${_genMapCode(outMap)}\n\n${_genDivCode(constructorList)}");
  }

  String _genMapCode(Map<String, String> map) {
    final buffer = StringBuffer();
    buffer.writeln("const _divMap = <String, Type>{");
    map.forEach((key, value) {
      buffer.writeln("  \"$key\": $value,");
    });
    buffer.writeln("};");
    return buffer.toString();
  }

  String _genDivCode(List<String> constructorList) {
    final ret = constructorList
        .map((c) =>
            "      $c => $c(className: className, option: option, children: children),")
        .join("\n");

    return "class \$Div extends StatelessWidget {\n"
        "  const \$Div({\n"
        "   super.key, required this.className, required this.children,\n"
        "   this.option = const EasyOption.empty(),\n"
        "  });\n"
        "  final String className;\n"
        "  final EasyOption option;\n"
        "  final List<Widget> children;\n\n"
        "  @override\n"
        "  Widget build(BuildContext context) {\n"
        "    Type? type = _divMap[className.trim()];\n"
        "    if (type == null) return Column(children: children);\n"
        "    return switch (type) {\n"
        "$ret\n"
        "      _ => Column(children: children),\n"
        "    };\n"
        "  }\n"
        "}\n";
  }
}
