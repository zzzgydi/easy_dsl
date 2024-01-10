import "package:easy_dsl_gen/generator/code/code_gen.dart";

import "attr.dart";

final safePattern = RegExp(r"safe(?:-(inner|outer))?(-[tlrbxy])?");

class SafeAreaIter extends AttrIter {
  bool _it = false, _ib = false, _il = false, _ir = false;
  bool _ot = false, _ob = false, _ol = false, _or = false;

  bool get hasInner => _it || _ib || _il || _ir;
  bool get hasOuter => _ot || _ob || _ol || _or;

  @override
  void iter(String cls) {
    if (safePattern.hasMatch(cls)) {
      final match = safePattern.firstMatch(cls)!;
      final safe = match.group(1) ?? "inner";
      final dir = match.group(2);

      if (safe == "inner") {
        switch (dir) {
          case "-t":
            _it = true;
            break;
          case "-b":
            _ib = true;
            break;
          case "-l":
            _il = true;
            break;
          case "-r":
            _ir = true;
            break;
          case "-x":
            _il = true;
            _ir = true;
            break;
          case "-y":
            _it = true;
            _ib = true;
            break;
          default:
            _it = true;
            _ib = true;
            _il = true;
            _ir = true;
        }
        return;
      }

      if (safe == "outer") {
        switch (dir) {
          case "-t":
            _ot = true;
            break;
          case "-b":
            _ob = true;
            break;
          case "-l":
            _ol = true;
            break;
          case "-r":
            _or = true;
            break;
          case "-x":
            _ol = true;
            _or = true;
            break;
          case "-y":
            _ot = true;
            _ob = true;
            break;
          default:
            _ot = true;
            _ob = true;
            _ol = true;
            _or = true;
        }
        return;
      }
    }
  }

  String? wrapperInner(String? child) {
    if (child == null) return null;
    if (!hasInner) return child;

    final code = CodeConstrutor("SafeArea")
      ..add("top", _it.toString())
      ..add("bottom", _ib.toString())
      ..add("left", _il.toString())
      ..add("right", _ir.toString())
      ..add("child", child);

    return code.generate();
  }

  String? wrapperOuter(String? child) {
    if (child == null) return null;
    if (!hasOuter) return child;

    final code = CodeConstrutor("SafeArea")
      ..add("top", _ot.toString())
      ..add("bottom", _ob.toString())
      ..add("left", _ol.toString())
      ..add("right", _or.toString())
      ..add("child", child);

    return code.generate();
  }
}
