import 'attr.dart';

class BackgroundIter extends AttrIter {
  String? color;

  @override
  void iter(String cls) {
    if (cls.startsWith("bg-[")) {
      final v = cls.substring(4, cls.length - 1);
      color = "colorV('$v')";
    } else if (cls.startsWith("bg-")) {
      final v = cls.substring(3);
      color = "color('$v')";
    }
  }

  @override
  String? generate() {
    return color;
  }
}
