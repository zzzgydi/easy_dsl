import 'package:flutter/material.dart';

import 'div.dart';

class Demo1Page extends StatelessWidget {
  const Demo1Page({super.key});

  @override
  Widget build(BuildContext context) {
    const className = "items-center bg-black/50";

    return const Div(
      className: className,
      children: [
        Div(
          className: "bg-red-500 pt-[10] px-[100] py-[20] gap-4",
          children: [
            Div(
              className:
                  "px-10 bg-gray-400 w-[200] h-20 flex items-center gap-[4]",
              children: [
                Text('This is'),
                Text('EasyDSL'),
              ],
            ),
            Div(
              className: "flex items-center p-[10] bg-gray-500/50",
              children: [
                Text('Hello'),
                SizedBox(width: 10),
                Div(
                  className:
                      "bg-orange-100/50 p-2 border-x-[10] border-red-500",
                  children: [
                    Text('World'),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
