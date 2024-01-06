import 'package:flutter/material.dart';

import 'div.dart';

class Demo1Page extends StatelessWidget {
  const Demo1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hello'),
        Div(
          className: "flex items-center demo1",
          children: [
            Div(
              className: "text demo1",
              children: [
                Text("test"),
                Div(
                  className: "demo1 flex inline items-center",
                  children: [Text("test")],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
