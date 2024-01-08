import 'cls_item.dart';
import 'iter/iter.dart';

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

    var widget = "$inner(\n"
        "  mainAxisSize: $mainAxisSize,\n"
        "  mainAxisAlignment: $mainAxisAlignment,\n"
        "  crossAxisAlignment: $crossAxisAlignment,\n"
        "  children: children,\n"
        ")";

    var bgIter = BackgroundIter();
    var borderIter = BorderIter();
    var paddingIter = PaddingIter();

    for (var cls in clsItem.clsSet) {
      bgIter.iter(cls);
      borderIter.iter(cls);
      paddingIter.iter(cls);
    }

    final background = bgIter.generate();
    final border = borderIter.generate();
    final padding = paddingIter.generate();

    if (background != null || border != null || padding != null) {
      final o = StringBuffer();
      o.writeln("Container(");
      // o.writeln("width: double.infinity,");
      // o.writeln("height: double.infinity,");
      if (padding != null) {
        o.writeln("padding: $padding,");
      }
      if (background != null || border != null) {
        o.writeln("decoration: BoxDecoration(");
        if (background != null) o.writeln("color: $background,");
        if (border != null) o.writeln("border: $border,");
        o.writeln("),");
      }
      o.writeln("child: $widget,");
      o.writeln(")");
      widget = o.toString();
    }

    return "class $constructor extends EasyDivImpl {\n"
        "  const $constructor({\n"
        "    super.key, required super.className, required super.children,\n"
        "    required super.option,\n"
        "  });\n"
        "  @override\n"
        "  Widget build(BuildContext context) {\n"
        "    return $widget;\n"
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
