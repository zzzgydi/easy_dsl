import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_dsl/easy_dsl.dart';

part 'div.easy.g.dart';

@EasyDSL()
class Div extends $Div {
  const Div({super.key, required super.className, super.children})
      : super(option: const EasyOption.empty());
}
