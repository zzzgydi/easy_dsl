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

    var widget = "$inner(\n"
        "  mainAxisSize: $mainAxisSize,\n"
        "  mainAxisAlignment: $mainAxisAlignment,\n"
        "  crossAxisAlignment: $crossAxisAlignment,\n"
        "  children: children,\n"
        ")";

    final background = _calBackground();
    final border = _calBorder();
    final padding = _calPadding();

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

    return "class $constructor extends \$DivImpl {\n"
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

  String? _calBackground() {
    String? color;

    for (final cls in clsItem.clsSet) {
      if (cls.startsWith("bg-[")) {
        final v = cls.substring(4, cls.length - 1);
        color = "_colorV('$v')";
      } else if (cls.startsWith("bg-")) {
        final v = cls.substring(3);
        color = "_color('$v')";
      }
    }
    if (color == null) {
      return null;
    }
    return color;
  }

  String? _calBorder() {
    String? tColor, tWidth, tStyle;
    String? lColor, lWidth, lStyle;
    String? rColor, rWidth, rStyle;
    String? bColor, bWidth, bStyle;

    for (final cls in clsItem.clsSet) {
      switch (cls) {
        case "border-solid":
          tStyle = "BorderStyle.solid";
          lStyle = "BorderStyle.solid";
          rStyle = "BorderStyle.solid";
          bStyle = "BorderStyle.solid";
          continue;
        case "border-t-solid":
          tStyle = "BorderStyle.solid";
          continue;
        case "border-l-solid":
          lStyle = "BorderStyle.solid";
          continue;
        case "border-r-solid":
          rStyle = "BorderStyle.solid";
          continue;
        case "border-b-solid":
          bStyle = "BorderStyle.solid";
          continue;
        case "border-dashed":
        case "border-dotted":
        case "border-double":
        case "border-none":
          tStyle = "BorderStyle.none";
          lStyle = "BorderStyle.none";
          rStyle = "BorderStyle.none";
          bStyle = "BorderStyle.none";
          continue;
        case "border-t-dashed":
        case "border-t-dotted":
        case "border-t-double":
        case "border-t-none":
          tStyle = "BorderStyle.none";
          continue;
        case "border-l-dashed":
        case "border-l-dotted":
        case "border-l-double":
        case "border-l-none":
          lStyle = "BorderStyle.none";
          continue;
        case "border-r-dashed":
        case "border-r-dotted":
        case "border-r-double":
        case "border-r-none":
          rStyle = "BorderStyle.none";
          continue;
        case "border-b-dashed":
        case "border-b-dotted":
        case "border-b-double":
        case "border-b-none":
          bStyle = "BorderStyle.none";
          continue;
      }

      final pattern = RegExp(r'^border(-[tlrbxy])?(-\d)?$');
      if (pattern.hasMatch(cls)) {
        final match = pattern.firstMatch(cls)!;
        final side = match.group(1);
        final width = match.group(2) ?? "1";
        switch (side) {
          case "-t":
            tWidth = width;
            break;
          case "-l":
            lWidth = width;
            break;
          case "-r":
            rWidth = width;
            break;
          case "-b":
            bWidth = width;
            break;
          case "-x":
            lWidth = width;
            rWidth = width;
            break;
          case "-y":
            tWidth = width;
            bWidth = width;
            break;
          default:
            tWidth = width;
            lWidth = width;
            rWidth = width;
            bWidth = width;
            break;
        }
        continue;
      }

      final pattern2 =
          RegExp(r'^border(-[tlrbxy])?-(solid|none|dashed|dotted|double)$');
      if (pattern2.hasMatch(cls)) {
        final match = pattern2.firstMatch(cls)!;
        final side = match.group(1);
        var style = match.group(2) ?? "solid";
        if (style != "none") {
          style = "solid";
        }

        switch (side) {
          case "-t":
            tStyle = "BorderStyle.$style";
            break;
          case "-l":
            lStyle = "BorderStyle.$style";
            break;
          case "-r":
            rStyle = "BorderStyle.$style";
            break;
          case "-b":
            bStyle = "BorderStyle.$style";
            break;
          case "-x":
            lStyle = "BorderStyle.$style";
            rStyle = "BorderStyle.$style";
            break;
          case "-y":
            tStyle = "BorderStyle.$style";
            bStyle = "BorderStyle.$style";
            break;
          default:
            tStyle = "BorderStyle.$style";
            lStyle = "BorderStyle.$style";
            rStyle = "BorderStyle.$style";
            bStyle = "BorderStyle.$style";
            break;
        }
        continue;
      }

      final pattern3 = RegExp(r'^border(-[tlrbxy])?-(\[.+?\]|.+)$');
      if (pattern3.hasMatch(cls)) {
        final match = pattern3.firstMatch(cls)!;
        final side = match.group(1);
        final color = match.group(2) ?? "current";
        final cValue = (color.startsWith('[') && color.endsWith(']'))
            ? "_colorV('$color')"
            : "_color('$color')";

        switch (side) {
          case "-t":
            tColor = cValue;
            break;
          case "-l":
            lColor = cValue;
            break;
          case "-r":
            rColor = cValue;
            break;
          case "-b":
            bColor = cValue;
            break;
          case "-x":
            lColor = cValue;
            rColor = cValue;
            break;
          case "-y":
            tColor = cValue;
            bColor = cValue;
            break;
          default:
            tColor = cValue;
            lColor = cValue;
            rColor = cValue;
            bColor = cValue;
            break;
        }
        continue;
      }
    }

    if (tColor == null &&
        tWidth == null &&
        tStyle == null &&
        lColor == null &&
        lWidth == null &&
        lStyle == null &&
        rColor == null &&
        rWidth == null &&
        rStyle == null &&
        bColor == null &&
        bWidth == null &&
        bStyle == null) {
      return null;
    }

    final List<String> sides = [];
    if (tColor != null || tWidth != null || tStyle != null) {
      tColor ??= "_color('current')";
      tWidth ??= "1";
      tStyle ??= "BorderStyle.solid";
      sides.add(
          "top: BorderSide(color: $tColor, width: $tWidth, style: $tStyle),\n");
    }
    if (lColor != null || lWidth != null || lStyle != null) {
      lColor ??= "_color('current')";
      lWidth ??= "1";
      lStyle ??= "BorderStyle.solid";
      sides.add(
          "left: BorderSide(color: $lColor, width: $lWidth, style: $lStyle),\n");
    }
    if (rColor != null || rWidth != null || rStyle != null) {
      rColor ??= "_color('current')";
      rWidth ??= "1";
      rStyle ??= "BorderStyle.solid";
      sides.add(
          "right: BorderSide(color: $rColor, width: $rWidth, style: $rStyle),\n");
    }
    if (bColor != null || bWidth != null || bStyle != null) {
      bColor ??= "_color('current')";
      bWidth ??= "1";
      bStyle ??= "BorderStyle.solid";
      sides.add(
          "bottom: BorderSide(color: $bColor, width: $bWidth, style: $bStyle),\n");
    }

    return "Border(\n${sides.join()})";
  }

  String? _calPadding() {
    String top = "0", left = "0", right = "0", bottom = "0";

    parseDouble(String cls, int begin) {
      final v = double.parse(cls.substring(begin, cls.length - 1));
      if (v > 0 && !v.isNaN) return "$v";
      return "0";
    }

    parseOption(String cls, int begin) => "_spacing('${cls.substring(begin)}')";

    for (final cls in clsItem.clsSet) {
      // parse arbitrary values
      if (cls.startsWith("p-[")) {
        final v = parseDouble(cls, 3);
        top = v;
        left = v;
        right = v;
        bottom = v;
      } else if (cls.startsWith("pt-[")) {
        top = parseDouble(cls, 4);
      } else if (cls.startsWith("pl-[")) {
        left = parseDouble(cls, 4);
      } else if (cls.startsWith("pr-[")) {
        right = parseDouble(cls, 4);
      } else if (cls.startsWith("pb-[")) {
        bottom = parseDouble(cls, 4);
      } else if (cls.startsWith("px-[")) {
        left = parseDouble(cls, 4);
        right = left;
      } else if (cls.startsWith("py-[")) {
        top = parseDouble(cls, 4);
        bottom = top;
      }
      // parse option
      else if (cls.startsWith("p-")) {
        final v = parseOption(cls, 2);
        top = v;
        left = v;
        right = v;
        bottom = v;
      } else if (cls.startsWith("pt-")) {
        top = parseOption(cls, 3);
      } else if (cls.startsWith("pl-")) {
        left = parseOption(cls, 3);
      } else if (cls.startsWith("pr-")) {
        right = parseOption(cls, 3);
      } else if (cls.startsWith("pb-")) {
        bottom = parseOption(cls, 3);
      } else if (cls.startsWith("px-")) {
        left = parseOption(cls, 3);
        right = left;
      } else if (cls.startsWith("py-")) {
        top = parseOption(cls, 3);
        bottom = top;
      }
    }

    if (top == "0" && left == "0" && right == "0" && bottom == "0") {
      return null;
    }
    return "EdgeInsets.only(top: $top, left: $left, right: $right, bottom: $bottom)";
  }
}
