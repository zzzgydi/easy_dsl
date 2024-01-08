import 'package:flutter/material.dart';

class GenDemo1 extends StatelessWidget {
  const GenDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.black, width: 1),
        border: const Border(
          top: BorderSide(color: Colors.black, width: 1),
          // left: BorderSide(color: Colors.black, width: 1),
          // right: BorderSide(color: Colors.black, width: 1),
          // bottom: BorderSide(color: Colors.black, width: 1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
