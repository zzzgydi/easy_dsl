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
    final mainAxisAlignment = choose({
      "justify-center": "MainAxisAlignment.center",
      "justify-end": "MainAxisAlignment.end",
      "justify-between": "MainAxisAlignment.spaceBetween",
      "justify-around": "MainAxisAlignment.spaceAround",
      "justify-evenly": "MainAxisAlignment.spaceEvenly",
    }, "MainAxisAlignment.start");
    final crossAxisAlignment = choose({
      "items-start": "CrossAxisAlignment.start",
      "items-end": "CrossAxisAlignment.end",
      "items-center": "CrossAxisAlignment.center",
      "items-stretch": "CrossAxisAlignment.stretch",
      "items-baseline": "CrossAxisAlignment.baseline",
    }, "CrossAxisAlignment.start");

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

  String choose(Map<String, String> map, String defaultValue) {
    var out = defaultValue;
    for (var key in map.keys) {
      if (clsItem.clsSet.contains(key)) {
        out = map[key]!;
      }
    }
    return out;
  }
}
