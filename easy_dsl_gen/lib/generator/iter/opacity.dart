import 'attr.dart';

final opacityPattern = RegExp(r'^opacity-(\[\.\d+\]|\d+)$');

class OpacityIter extends AttrIter {
  String? _opacity;

  @override
  void iter(String cls) {
    if (opacityPattern.hasMatch(cls)) {
      var value = opacityPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      if (value.startsWith('[') && value.endsWith(']')) {
        value = value.substring(1, value.length - 1);
      } else {
        var v = (double.parse(value) / 100);
        if (v > 1) v = 1;
        if (v < 0) v = 0;
        value = "$v";
      }
      _opacity = value;
    }
  }

  @override
  String? wrapper(String? child) {
    if (_opacity == null) return child;
    return "Opacity(opacity: $_opacity, child: $child)";
  }
}
