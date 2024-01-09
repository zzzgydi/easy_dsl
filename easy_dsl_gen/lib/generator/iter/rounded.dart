import 'package:easy_dsl_gen/generator/code/code_gen.dart';

import 'attr.dart';

final roundedPattern =
    RegExp(r'^rounded(-[tlrb]{1,2})?(?:-(\[\d+(?:\.\d+)?\]|.+))?$');

class RoundedIter extends AttrIter {
  String? tl, tr, bl, br;

  @override
  void iter(String cls) {
    if (cls == "rounded") {
      tl = "Radius.circular(rounded('default'))";
      tr = tl;
      bl = tl;
      br = tl;
      return;
    }
    if (roundedPattern.hasMatch(cls)) {
      final match = roundedPattern.firstMatch(cls)!;
      final side = match.group(1);
      final radius = parseRounded(match.group(2));

      switch (side) {
        case "-t":
          tl = radius;
          tr = radius;
          break;
        case "-l":
          tl = radius;
          bl = radius;
          break;
        case "-r":
          tr = radius;
          br = radius;
          break;
        case "-b":
          bl = radius;
          br = radius;
          break;
        case "-lt":
        case "-tl":
          tl = radius;
          break;
        case "-rt":
        case "-tr":
          tr = radius;
          break;
        case "-lb":
        case "-bl":
          bl = radius;
          break;
        case "-rb":
        case "-br":
          br = radius;
          break;
        default:
          tl = radius;
          tr = radius;
          bl = radius;
          br = radius;
          break;
      }
    }
  }

  @override
  String? generate() {
    final radius = CodeConstrutor("BorderRadius.only")
      ..add("topLeft", tl)
      ..add("topRight", tr)
      ..add("bottomLeft", bl)
      ..add("bottomRight", br);
    return radius.maybeGenerate();
  }

  String? parseRounded(String? radius) {
    if (radius == null || radius == "none") return null;
    var v = "rounded('$radius')";
    if (radius.startsWith("[") && radius.endsWith("]")) {
      v = radius.substring(1, radius.length - 1);
    }
    return "Radius.circular($v)";
  }
}
