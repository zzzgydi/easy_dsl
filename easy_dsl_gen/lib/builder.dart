import 'package:build/build.dart';

import 'src/custom_builder.dart';
import 'src/custom_combine_builder.dart';

Builder customBuilder(BuilderOptions options) => CustomBuilder();

Builder customCombineBuilder(BuilderOptions options) => CustomCombineBuilder();
