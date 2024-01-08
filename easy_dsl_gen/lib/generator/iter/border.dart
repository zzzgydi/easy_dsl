import 'attr.dart';

class BorderIter extends AttrIter {
  String? tColor, tWidth, tStyle;
  String? lColor, lWidth, lStyle;
  String? rColor, rWidth, rStyle;
  String? bColor, bWidth, bStyle;

  @override
  void iter(String cls) {
    final pattern = RegExp(r'^border(-[tlrbxy])?(-\d+)?$');
    if (pattern.hasMatch(cls)) {
      final match = pattern.firstMatch(cls)!;
      final side = match.group(1);
      final width = (match.group(2) ?? "1").replaceFirst("-", '');
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
      return;
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
      return;
    }

    final pattern3 = RegExp(r'^border(-[tlrbxy])?-(\[.+?\]|.+)$');
    if (pattern3.hasMatch(cls)) {
      final match = pattern3.firstMatch(cls)!;
      final side = match.group(1);
      final color = match.group(2) ?? "current";
      // TODO tranform colorV
      final cValue = (color.startsWith('[') && color.endsWith(']'))
          ? "colorV('$color')"
          : "color('$color')";

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
      return;
    }
  }

  @override
  String? generate() {
    /// must set border width
    /// if not set, return null
    if (tWidth == null && lWidth == null && rWidth == null && bWidth == null) {
      return null;
    }

    final List<String> sides = [];
    if (tWidth != null) {
      tColor ??= "color('current')";
      tWidth ??= "1";
      tStyle ??= "BorderStyle.solid";
      sides.add(
          "top: BorderSide(color: $tColor, width: $tWidth, style: $tStyle),\n");
    }
    if (lWidth != null) {
      lColor ??= "color('current')";
      lWidth ??= "1";
      lStyle ??= "BorderStyle.solid";
      sides.add(
          "left: BorderSide(color: $lColor, width: $lWidth, style: $lStyle),\n");
    }
    if (rWidth != null) {
      rColor ??= "color('current')";
      rWidth ??= "1";
      rStyle ??= "BorderStyle.solid";
      sides.add(
          "right: BorderSide(color: $rColor, width: $rWidth, style: $rStyle),\n");
    }
    if (bWidth != null) {
      bColor ??= "color('current')";
      bWidth ??= "1";
      bStyle ??= "BorderStyle.solid";
      sides.add(
          "bottom: BorderSide(color: $bColor, width: $bWidth, style: $bStyle),\n");
    }

    return "Border(${sides.join()})";
  }
}
