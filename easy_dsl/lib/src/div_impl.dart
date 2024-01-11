import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'options.dart';

class EasyDivImpl extends StatelessWidget {
  const EasyDivImpl({
    super.key,
    required this.className,
    required this.option,
    this.children,
  });
  final String className;
  final EasyOption option;
  final List<Widget>? children;

  double spacing(String key) {
    return option.spacing[key] ?? 0;
  }

  double? spacingOr(String key) {
    return option.spacing[key];
  }

  Color color(String key) {
    return option.color[key] ?? Colors.transparent;
  }

  double rounded(String key) {
    return option.borderRadius[key] ?? 0;
  }

  double aspectRatio(String key) {
    final v = option.aspectRatio[key];
    if (kDebugMode && v == null) {
      print(
          "[EasyDSL] Warning: `aspect-$key` not set, please check your option.");
    }
    return v ?? 1;
  }

  List<Widget> joinSpacer(List<Widget>? children, Widget spacer) {
    if (children == null || children.isEmpty) {
      return const [];
    }
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(spacer);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
