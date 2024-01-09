import 'package:easy_dsl_gen/generator/iter/utils.dart';

void main() {
  final className =
      "border-t-1 border-[#909090]/[.02] border-[30.2] border-hello/80 "
      "border-[rgb(100,100,200)]";

  final widthPattern =
      RegExp(r'^border(-[tlrbxy])?(?:-(\d+|\[\d+(?:\.\d+)?\]))?$');
  final colorPattern =
      RegExp(r'^border(-[tlrbxy])?-(\[.+?\]|.+?)(?:/(\[\.\d+\]|\d+))?$');

  final clsList = className.split(" ").map((e) => e.trim()).toList();
  for (var cls in clsList) {
    // width
    if (widthPattern.hasMatch(cls)) {
      final match = widthPattern.firstMatch(cls)!;
      final side = match.group(1);
      final width = (match.group(2) ?? "1");
      var w = width;
      if (width.startsWith('[') && width.endsWith(']')) {
        w = width.substring(1, width.length - 1);
      }
      print("src: $cls \n== mode: width \n== side: $side \n== width: $w");
    }
    // color
    else if (colorPattern.hasMatch(cls)) {
      final match = colorPattern.firstMatch(cls)!;
      final side = match.group(1);
      final color = match.group(2);
      final alpha = match.group(3);

      String? value;
      if (color != null) {
        value = parseColor(color, alpha);
      }

      print("src: $cls \n== mode: color \n== side: $side \n== color: $value");
    }
  }
}
