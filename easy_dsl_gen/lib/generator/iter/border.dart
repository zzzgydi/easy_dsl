import 'package:easy_dsl_gen/generator/code/code_gen.dart';

import 'attr.dart';
import 'utils.dart';

final borderWidthPattern =
    RegExp(r'^border(-[tlrbxy])?(?:-(\d+|\[\d+(?:\.\d+)?\]))?$');
final borderStylePattern =
    RegExp(r'^border(-[tlrbxy])?-(solid|none|dashed|dotted|double)$');
final borderColorPattern =
    RegExp(r'^border(-[tlrbxy])?-(\[.+?\]|.+?)(?:/(\[\.\d+\]|\d+))?$');

class BorderIter extends AttrIter {
  String? tColor, tWidth, tStyle;
  String? lColor, lWidth, lStyle;
  String? rColor, rWidth, rStyle;
  String? bColor, bWidth, bStyle;

  @override
  void iter(String cls) {
    if (borderWidthPattern.hasMatch(cls)) {
      final match = borderWidthPattern.firstMatch(cls)!;
      final side = match.group(1);
      var width = (match.group(2) ?? "1");
      if (width.startsWith('[') && width.endsWith(']')) {
        width = width.substring(1, width.length - 1);
      }
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

    if (borderStylePattern.hasMatch(cls)) {
      final match = borderStylePattern.firstMatch(cls)!;
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

    if (borderColorPattern.hasMatch(cls)) {
      final match = borderColorPattern.firstMatch(cls)!;
      final side = match.group(1);
      final color = match.group(2);
      final alpha = match.group(3);

      final value = parseColor(color, alpha);
      if (value == null) return;

      switch (side) {
        case "-t":
          tColor = value;
          break;
        case "-l":
          lColor = value;
          break;
        case "-r":
          rColor = value;
          break;
        case "-b":
          bColor = value;
          break;
        case "-x":
          lColor = value;
          rColor = value;
          break;
        case "-y":
          tColor = value;
          bColor = value;
          break;
        default:
          tColor = value;
          lColor = value;
          rColor = value;
          bColor = value;
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

    final top = tWidth != null
        ? (CodeConstrutor("BorderSide")
              ..add("color", tColor)
              ..add("width", tWidth)
              ..add("style", tStyle))
            .maybeGenerate()
        : null;
    final left = lWidth != null
        ? (CodeConstrutor("BorderSide")
              ..add("color", lColor)
              ..add("width", lWidth)
              ..add("style", lStyle))
            .maybeGenerate()
        : null;
    final right = rWidth != null
        ? (CodeConstrutor("BorderSide")
              ..add("color", rColor)
              ..add("width", rWidth)
              ..add("style", rStyle))
            .maybeGenerate()
        : null;
    final bottom = bWidth != null
        ? (CodeConstrutor("BorderSide")
              ..add("color", bColor)
              ..add("width", bWidth)
              ..add("style", bStyle))
            .maybeGenerate()
        : null;

    return (CodeConstrutor("Border")
          ..add("top", top)
          ..add("left", left)
          ..add("right", right)
          ..add("bottom", bottom))
        .generate();
  }
}
