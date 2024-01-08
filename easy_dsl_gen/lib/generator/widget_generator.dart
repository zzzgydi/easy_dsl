import 'cls_item.dart';
import 'code/code_gen.dart';
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
    final marginIter = MarginIter();

    for (var cls in clsItem.clsSet) {
      boxIter.iter(cls);
      bgIter.iter(cls);
      borderIter.iter(cls);
      paddingIter.iter(cls);
      marginIter.iter(cls);
    }

    var current = boxIter.generate();

    final background = bgIter.generate();
    final border = borderIter.generate();
    final padding = paddingIter.generate();
    final margin = marginIter.generate();

    final container = CodeConstrutor("Container")
      ..add("margin", margin)
      ..add("padding", padding)
      ..add(
          "decoration",
          (CodeConstrutor("BoxDecoration")
                ..add("color", background)
                ..add("border", border))
              .maybeGenerate());

    if (container.hasFields()) {
      container.add("child", current);
      current = container.generate();
    }

    return "class $constructor extends EasyDivImpl {\n"
        "  const $constructor({\n"
        "    super.key, required super.className, required super.children,\n"
        "    required super.option,\n"
        "  });\n"
        "  @override\n"
        "  Widget build(BuildContext context) {\n"
        "    return $current;\n"
        "  }\n"
        "}";
  }
}
