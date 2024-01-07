import 'package:flutter/material.dart';

import 'div.dart';

class Demo1Page extends StatelessWidget {
  const Demo1Page({super.key});

  final String test = "";

  @override
  Widget build(BuildContext context) {
    const className =
        "demo1 items-center test-SimpleIdentifier & inConstantContext";

    const a = "this is abc";
    const className2 = "demo1 test $a";

    return Column(
      children: [
        const Text('Hello'),
        Div(
          className: "flex items-center demo1",
          children: [
            Div(
              className: "text demo1",
              children: [
                const Text("test"),
                const Div(
                  className: "demo1 flex inline items-center",
                  children: [Text("test")],
                ),
                const Div(
                  className: className,
                  children: [Text("test")],
                ),
                const Div(
                  className: className2,
                  children: [Text("test")],
                ),
                Div(
                  className: test,
                  children: const [Text("test")],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
