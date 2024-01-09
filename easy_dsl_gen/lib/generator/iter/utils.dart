final colorPattern =
    RegExp(r'^\[(#[a-fA-F0-9]{6}|rgb\(\d+,\d+,\d+\)|hsl\(\d+,\d+%,\d+%\))\]$');

final rgbPattern = RegExp(r'^rgb\((\d+),(\d+),(\d+)\)$');
final hslPattern = RegExp(r'^hsl\((\d+),(\d+)%,(\d+)%\)$');

/// text: [#ffffff] [rgb(100,101,101)] [hsl(180,100%,50%)] currentColor
/// alpha: 10 [0.1] [.1]
String? parseColor(String? text, String? alpha) {
  if (text == null) return null;

  final a = parseAlpha(alpha);
  if (colorPattern.hasMatch(text)) {
    final color = colorPattern.firstMatch(text)?.group(1);
    if (color == null) return null;

    if (color.startsWith('#')) {
      final c = color.substring(1);
      final af = (a * 255).toInt().toRadixString(16).padLeft(2, '0');
      return "Color(0x$af$c)";
    }
    if (rgbPattern.hasMatch(color)) {
      final match = rgbPattern.firstMatch(color)!;
      final r = match.group(1);
      final g = match.group(2);
      final b = match.group(3);
      return "Color.fromRGBO($r,$g,$b,$a)";
    }
    if (hslPattern.hasMatch(color)) {
      final match = hslPattern.firstMatch(color)!;
      final h = match.group(1);
      final s = double.parse(match.group(2) ?? "100");
      final l = double.parse(match.group(3) ?? "100");
      return "HSLColor.fromAHSL($a,$h,$s,$l).toColor()";
    }
  }
  if (text.startsWith('[') && text.endsWith(']')) {
    return null;
  }

  if (a >= 1) return "color('$text')";

  final ai = (a * 255).toInt();
  return "color('$text').withAlpha($ai)";
}

double parseAlpha(String? alpha) {
  if (alpha == null) return 1;

  double value = 1;
  if (alpha.startsWith('[') && alpha.endsWith(']')) {
    value = double.parse(alpha.substring(1, alpha.length - 1));
  } else {
    value = double.parse(alpha) / 100;
  }

  if (value.isNaN) {
    value = 1;
  } else if (value < 0) {
    value = 0;
  } else if (value > 1) {
    value = 1;
  }

  return value;
}
