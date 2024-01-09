import 'dart:ui';
import 'defaults.dart';

// TODO
class EasyOption {
  final Map<String, double> spacing;

  final Map<String, double> borderRadius;

  final Map<String, Color> color;

  const EasyOption({
    this.spacing = defaultSpacing,
    this.color = defaultColor,
    this.borderRadius = defaultBorderRadius,
  });

  const EasyOption.empty()
      : color = defaultColor,
        spacing = defaultSpacing,
        borderRadius = defaultBorderRadius;
}
