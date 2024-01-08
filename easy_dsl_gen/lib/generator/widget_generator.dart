import 'cls_item.dart';
import 'iter/iter.dart';

class WidgetGenerator {
  WidgetGenerator(this.clsItem, this.constructor);

  final ClsItem clsItem;
  final String constructor;

  String generate() {
    final boxIter = BoxIter();
    final bgIter = BackgroundIter();
    final borderIter = BorderIter();
    final paddingIter = PaddingIter();

    for (var cls in clsItem.clsSet) {
      boxIter.iter(cls);
      bgIter.iter(cls);
      borderIter.iter(cls);
      paddingIter.iter(cls);
    }

    var widget = boxIter.generate();
    final background = bgIter.generate();
    final border = borderIter.generate();
    final padding = paddingIter.generate();

    if (background != null || border != null || padding != null) {
      final o = StringBuffer();
      o.writeln("Container(");
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

  // bool has(String cls) {
  //   return clsItem.clsSet.contains(cls);
  // }

  // bool not(String cls) {
  //   return !clsItem.clsSet.contains(cls);
  // }

  // String choose(Map<String, String> map, String defaultValue) {
  //   var out = defaultValue;
  //   for (var key in map.keys) {
  //     if (clsItem.clsSet.contains(key)) {
  //       out = map[key]!;
  //     }
  //   }
  //   return out;
  // }
}
