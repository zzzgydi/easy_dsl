import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/div_gen.dart';
import 'src/lib_gen.dart';
import 'src/test.dart';

Builder easyBuilder(BuilderOptions options) =>
    SharedPartBuilder([DivUsageGenerator2()], 'easy');
