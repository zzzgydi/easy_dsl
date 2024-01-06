import 'package:flutter/material.dart';
import 'package:easy_dsl/easy_dsl.dart';

@EasyDSL('div')
class Div extends StatelessWidget {
  const Div({
    super.key,
    required this.className,
    required this.children,
  });

  final String className;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: children));
  }
}
