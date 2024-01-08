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

  Color color(String key) {
    return option.color[key] ?? Colors.transparent;
  }

  // TODO
  Color colorV(String value) {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
