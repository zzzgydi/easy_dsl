import 'package:flutter/material.dart';

import 'options.dart';

class EasyDivImpl extends StatelessWidget {
  const EasyDivImpl({
    super.key,
    required this.className,
    required this.children,
    required this.option,
  });
  final String className;
  final EasyOption option;
  final List<Widget> children;

  double spacing(String key) {
    return option.spacing[key] ?? 0;
  }

  double? spacingOr(String key) {
    return option.spacing[key];
  }

  Color color(String key) {
    return option.color[key] ?? Colors.transparent;
  }

  List<Widget> joinSpacer(List<Widget> children, Widget spacer) {
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
