import 'attr.dart';

class PaddingIter extends AttrIter {
  String top = "0", left = "0", right = "0", bottom = "0";

  @override
  void iter(String cls) {
    if (cls.startsWith("p-[")) {
      final v = _parseDouble(cls, 3);
      top = v;
      left = v;
      right = v;
      bottom = v;
    } else if (cls.startsWith("pt-[")) {
      top = _parseDouble(cls, 4);
    } else if (cls.startsWith("pl-[")) {
      left = _parseDouble(cls, 4);
    } else if (cls.startsWith("pr-[")) {
      right = _parseDouble(cls, 4);
    } else if (cls.startsWith("pb-[")) {
      bottom = _parseDouble(cls, 4);
    } else if (cls.startsWith("px-[")) {
      left = _parseDouble(cls, 4);
      right = left;
    } else if (cls.startsWith("py-[")) {
      top = _parseDouble(cls, 4);
      bottom = top;
    }
    // parse option
    else if (cls.startsWith("p-")) {
      final v = _parseOption(cls, 2);
      top = v;
      left = v;
      right = v;
      bottom = v;
    } else if (cls.startsWith("pt-")) {
      top = _parseOption(cls, 3);
    } else if (cls.startsWith("pl-")) {
      left = _parseOption(cls, 3);
    } else if (cls.startsWith("pr-")) {
      right = _parseOption(cls, 3);
    } else if (cls.startsWith("pb-")) {
      bottom = _parseOption(cls, 3);
    } else if (cls.startsWith("px-")) {
      left = _parseOption(cls, 3);
      right = left;
    } else if (cls.startsWith("py-")) {
      top = _parseOption(cls, 3);
      bottom = top;
    }
  }

  @override
  String? generate() {
    if (top == "0" && left == "0" && right == "0" && bottom == "0") {
      return null;
    }
    return "EdgeInsets.only(top: $top, left: $left, right: $right, bottom: $bottom)";
  }

  _parseDouble(String cls, int begin) {
    final v = double.parse(cls.substring(begin, cls.length - 1));
    if (v > 0 && !v.isNaN) return "$v";
    return "0";
  }

  _parseOption(String cls, int begin) => "spacing('${cls.substring(begin)}')";
}
