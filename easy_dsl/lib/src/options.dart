import 'dart:ui';
import 'defaults.dart';

// TODO
class EasyOption {
  final Map<String, double> spacing;

  final Map<String, double> borderRadius;

  final Map<String, double> aspectRatio;

  final Map<String, Color> color;

  const EasyOption({
    this.spacing = defaultSpacing,
    this.color = defaultColor,
    this.aspectRatio = defaultAspectRatio,
    this.borderRadius = defaultBorderRadius,
  });

  const EasyOption.empty()
      : color = defaultColor,
        spacing = defaultSpacing,
        aspectRatio = defaultAspectRatio,
        borderRadius = defaultBorderRadius;

  EasyOption.extend({
    Map<String, double>? extendSpacing,
    Map<String, double>? extendBorderRadius,
    Map<String, double>? extendAspectRatio,
    Map<String, Color>? extendColor,
  })  : spacing = {...defaultSpacing, ...?extendSpacing},
        borderRadius = {...defaultBorderRadius, ...?extendBorderRadius},
        aspectRatio = {...defaultAspectRatio, ...?extendAspectRatio},
        color = {...defaultColor, ...?extendColor};
}
