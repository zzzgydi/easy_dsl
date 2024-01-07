import 'cls_item.dart';

class WidgetGenerator {
  WidgetGenerator(this.clsItem, this.constructor);

  final ClsItem clsItem;
  final String constructor;

  String generate() {
    final inner = has("flex") && not("flex-col") ? "Row" : "Column";
    final mainAxisSize = has("inline") || has("inline-block")
        ? "MainAxisSize.min"
        : "MainAxisSize.max";
    final mainAxisAlignment = Case({
      "justify-center": "MainAxisAlignment.center",
      "justify-end": "MainAxisAlignment.end",
      "justify-between": "MainAxisAlignment.spaceBetween",
      "justify-around": "MainAxisAlignment.spaceAround",
      "justify-evenly": "MainAxisAlignment.spaceEvenly",
    }).run(clsItem.clsSet, "MainAxisAlignment.start");
    final crossAxisAlignment = Case({
      "items-start": "CrossAxisAlignment.start",
      "items-end": "CrossAxisAlignment.end",
      "items-center": "CrossAxisAlignment.center",
      "items-stretch": "CrossAxisAlignment.stretch",
      "items-baseline": "CrossAxisAlignment.baseline",
    }).run(clsItem.clsSet, "CrossAxisAlignment.start");

    final innerWidget = "$inner(\n"
        "  mainAxisSize: $mainAxisSize,\n"
        "  mainAxisAlignment: $mainAxisAlignment,\n"
        "  crossAxisAlignment: $crossAxisAlignment,\n"
        "  children: children,\n"
        ")";

    return "class $constructor extends StatelessWidget {\n"
        "  const $constructor({super.key, required this.className, required this.children});\n"
        "  final String className;\n"
        "  final List<Widget> children;\n\n"
        "  @override\n"
        "  Widget build(BuildContext context) {\n"
        "    return $innerWidget;\n"
        "  }\n"
        "}";
  }

  bool has(String cls) {
    return clsItem.clsSet.contains(cls);
  }

  bool not(String cls) {
    return !clsItem.clsSet.contains(cls);
  }
}

class Case {
  const Case(this.map);

  final Map<String, String> map;

  String run(Set<String> clsSet, String defaultValue) {
    var out = defaultValue;
    for (var key in map.keys) {
      if (clsSet.contains(key)) {
        out = map[key]!;
      }
    }
    return out;
  }
}
