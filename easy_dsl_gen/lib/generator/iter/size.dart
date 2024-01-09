import 'attr.dart';

final wPattern = RegExp(r'^w-(\[\d+(?:\.\d+)\]|.+)$');
final hPattern = RegExp(r'^h-(\[\d+(?:\.\d+)\]|.+)$');
final maxWidthPattern = RegExp(r'^max-w-(\[\d+(?:\.\d+)\]|.+)$');
final maxHeightPattern = RegExp(r'^max-h-(\[\d+(?:\.\d+)\]|.+)$');
final minWidthPattern = RegExp(r'^min-w-(\[\d+(?:\.\d+)\]|.+)$');
final minHeightPattern = RegExp(r'^min-h-(\[\d+(?:\.\d+)\]|.+)$');

class SizeIter extends AttrIter {
  String? width, height;
  String? maxWidth, maxHeight, minWidth, minHeight;

  @override
  void iter(String cls) {
    if (wPattern.hasMatch(cls)) {
      final value = wPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      width = parseValue(value);
    }

    if (hPattern.hasMatch(cls)) {
      final value = hPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      height = parseValue(value);
    }

    if (maxWidthPattern.hasMatch(cls)) {
      final value = maxWidthPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      maxWidth = parseValue(value);
    }

    if (maxHeightPattern.hasMatch(cls)) {
      final value = maxHeightPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      maxHeight = parseValue(value);
    }

    if (minWidthPattern.hasMatch(cls)) {
      final value = minWidthPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      minWidth = parseValue(value);
    }

    if (minHeightPattern.hasMatch(cls)) {
      final value = minHeightPattern.firstMatch(cls)?.group(1);
      if (value == null) return;
      minHeight = parseValue(value);
    }
  }

  String? parseValue(String value) {
    if (value == "auto") return null;
    if (value == "full") return "double.infinity";
    if (value.startsWith("[") && value.endsWith("]")) {
      return value.substring(1, value.length - 1);
    }
    return "spacingOr('$value')";
  }

  @override
  String? generate() {
    throw UnimplementedError();
  }
}
