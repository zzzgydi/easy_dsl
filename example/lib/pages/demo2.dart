import 'package:flutter/material.dart';

import 'div.dart';

class Demo2 extends StatelessWidget {
  const Demo2({super.key});

  @override
  Widget build(BuildContext context) {
    const div = Div(className: "flex items-center demo2", children: [
      Text('He'),
      Div(
        className: "flex inline items-center demo2",
        children: [Text("test")],
      ),
    ]);

    final data = "";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        div,
        Text(data),
        const Div(
          className: "demo2 test",
          children: [],
        )
      ],
    );
  }
}
