import 'attr.dart';

final aspectPattern = RegExp(r'^aspect-(\[\d+\/\d+\]|.+)$');

class AspectIter extends AttrIter {
  String? _ratio;

  @override
  void iter(String cls) {
    if (aspectPattern.hasMatch(cls)) {
      var value = aspectPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      if (value.startsWith('[') && value.endsWith(']')) {
        value = value.substring(1, value.length - 1);
      } else if (value == 'none' || value == "auto") {
        value = null;
      } else {
        value = "aspectRatio('$value')";
      }
      _ratio = value;
    }
  }

  @override
  String? wrapper(String? child) {
    if (_ratio == null) return child;
    return "AspectRatio(aspectRatio: $_ratio, child: $child)";
  }
}
