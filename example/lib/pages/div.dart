import 'package:flutter/material.dart';
import 'package:easy_dsl/easy_dsl.dart';

part 'div.easy.g.dart';

@EasyDSL()
class Div extends $Div {
  const Div({super.key, required super.className, required super.children})
      : super(option: const EasyOption.empty());
}
