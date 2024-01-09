import 'attr.dart';
import 'utils.dart';

final bgColorPattern = RegExp(r'^bg-(\[.+?\]|.+?)(?:/(\[\.\d+\]|\d+))?$');

class BackgroundIter extends AttrIter {
  String? color;

  @override
  void iter(String cls) {
    if (bgColorPattern.hasMatch(cls)) {
      final match = bgColorPattern.firstMatch(cls)!;
      final color = match.group(1);
      final alpha = match.group(2);

      this.color = parseColor(color, alpha);
    }
  }

  @override
  String? generate() {
    return color;
  }
}
