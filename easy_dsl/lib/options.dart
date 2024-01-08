import 'dart:ui';

// TODO
class EasyOption {
  const EasyOption({
    this.currentColor = const Color(0xFF000000),
  });

  const EasyOption.empty() : currentColor = const Color(0xFF000000);

  final Color currentColor;
}
