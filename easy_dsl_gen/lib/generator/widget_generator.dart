import 'cls_item.dart';
import 'code/code_gen.dart';
import 'iter/iter.dart';

class WidgetGenerator {
  WidgetGenerator(this.clsItem, this.constructor);

  final ClsItem clsItem;
  final String constructor;

  String generate() {
    final boxIter = BoxIter();
    final sizeIter = SizeIter();
    final bgIter = BackgroundIter();
    final borderIter = BorderIter();
    final paddingIter = PaddingIter();
    final marginIter = MarginIter();
    final roundedIter = RoundedIter();
    final aspectIter = AspectIter();
    final opacityIter = OpacityIter();

    for (var cls in clsItem.clsSet) {
      boxIter.iter(cls);
      sizeIter.iter(cls);
      bgIter.iter(cls);
      borderIter.iter(cls);
      paddingIter.iter(cls);
      marginIter.iter(cls);
      roundedIter.iter(cls);
      aspectIter.iter(cls);
      opacityIter.iter(cls);
    }

    var current = boxIter.generate();

    final container = CodeConstrutor("Container")
      ..add("margin", marginIter.generate())
      ..add("padding", paddingIter.generate())
      ..add("width", sizeIter.width)
      ..add("height", sizeIter.height)
      ..add(
          "decoration",
          (CodeConstrutor("BoxDecoration")
                ..add("color", bgIter.generate())
                ..add("border", borderIter.generate())
                ..add("borderRadius", roundedIter.generate()))
              .maybeGenerate())
      ..add(
          "constraints",
          (CodeConstrutor("BoxConstraints")
                ..add("maxWidth", sizeIter.maxWidth)
                ..add("maxHeight", sizeIter.maxHeight)
                ..add("minWidth", sizeIter.minWidth)
                ..add("minHeight", sizeIter.minHeight))
              .maybeGenerate());

    if (container.hasFields()) {
      container.add("child", current);
      current = container.generate();
    }

    current = aspectIter.wrapper(current);
    current = opacityIter.wrapper(current);

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
