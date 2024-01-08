import 'package:flutter/material.dart';

import 'div.dart';

class Demo1Page extends StatelessWidget {
  const Demo1Page({super.key});

  @override
  Widget build(BuildContext context) {
    const className = "items-center bg-black";

    return const Div(
      className: className,
      children: [
        Div(
          className: "bg-red-500 pt-[10] px-[100] py-[20]",
          children: [
            Div(
              className: "p-10 bg-gray-400",
              children: [
                Text('This is'),
                Text('EasyDSL'),
              ],
            ),
            SizedBox(height: 20),
            Div(
              className: "flex items-center p-[10] bg-gray-500",
              children: [
                Text('Hello'),
                SizedBox(width: 10),
                Div(
                  className: "bg-orange-100 p-2 border-x-3 border-red-500",
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
