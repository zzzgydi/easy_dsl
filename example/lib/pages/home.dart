import 'package:example/pages/div.dart';
import 'package:flutter/material.dart';

const a = 1;
const b = 2;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hello'),
        Div(className: "home flex items-center 1", children: [
          Text('He'),
        ])
      ],
    );
  }
}

class TestDemo extends StatelessWidget {
  const TestDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Div(
      className: "home flex items-center 2",
      children: [Text("test")],
    );
  }
}
