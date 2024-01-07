library easy_dsl_gen;

import 'package:build/build.dart';

import 'builder/combine_builder.dart';
import 'builder/part_builder.dart';

Builder easyPartBuilder(BuilderOptions options) => EasyPartBuilder();

Builder easyCombineBuilder(BuilderOptions options) => EasyCombineBuilder();
