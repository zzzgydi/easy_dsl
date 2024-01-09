import 'package:flutter/material.dart';

import 'div.dart';

class Demo1Page extends StatelessWidget {
  const Demo1Page({super.key});

  @override
  Widget build(BuildContext context) {
    const className = "items-center bg-black/50 w-full justify-center";

    return const Div(
      className: className,
      children: [
        Div(
          className: "bg-red-500 px-[100] py-[50] gap-4 rounded-2xl",
          children: [
            Div(
              className:
                  "bg-gray-400 w-[200] h-20 flex items-center justify-center gap-[4] rounded-tl-[20] rounded-br-[20]",
              children: [Text('This is'), Text('EasyDSL')],
            ),
            Div(
              className: "max-w-[200] flex items-center p-[10] bg-gray-500/50",
              children: [
                Text('Hello'),
                SizedBox(width: 10),
                Div(
                  className:
                      "bg-orange-100/50 p-2 border-x-[10] border-red-500 rounded-[10]",
                  children: [Text('World')],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
