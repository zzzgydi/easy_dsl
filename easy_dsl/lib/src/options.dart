import 'dart:ui';

const defaultSpacing = <String, double>{
  "px": 1,
  "0": 0,
  "0.5": 0.5,
  "1": 4,
  "1.5": 6,
  "2": 8,
  "2.5": 10,
  "3": 12,
  "3.5": 14,
  "4": 16,
  "5": 20,
  "6": 24,
  "7": 28,
  "8": 32,
  "9": 36,
  "10": 40,
  "11": 44,
  "12": 48,
  "14": 56,
  "16": 64,
  "20": 80,
  "24": 96,
  "28": 112,
  "32": 128,
  "36": 144,
  "40": 160,
  "44": 176,
  "48": 192,
  "52": 208,
  "56": 224,
  "60": 240,
  "64": 256,
  "72": 288,
  "80": 320,
  "96": 384,
};

const defaultColor = <String, Color>{
  "transparent": Color(0x00000000),
  "current": Color(0xFF000000),
  "black": Color(0xFF000000),
  "white": Color(0xFFFFFFFF),
  "gray-50": Color(0xFFFAFAFA),
  "gray-100": Color(0xFFF4F4F5),
  "gray-200": Color(0xFFE4E4E7),
  "gray-300": Color(0xFFD4D4D8),
  "gray-400": Color(0xFFA1A1AA),
  "gray-500": Color(0xFF71717A),
  "gray-600": Color(0xFF52525B),
  "gray-700": Color(0xFF3F3F46),
  "gray-800": Color(0xFF27272A),
  "gray-900": Color(0xFF18181B),
  "red-50": Color(0xFFFFF1F1),
  "red-100": Color(0xFFFFE4E4),
  "red-200": Color(0xFFFECACA),
  "red-300": Color(0xFFFCA5A5),
  "red-400": Color(0xFFF87171),
  "red-500": Color(0xFFEF4444),
  "red-600": Color(0xFFDC2626),
  "red-700": Color(0xFFB91C1C),
  "red-800": Color(0xFF991B1B),
  "red-900": Color(0xFF7F1D1D),
  "orange-50": Color(0xFFFFF7ED),
  "orange-100": Color(0xFFFFF0D2),
  "orange-200": Color(0xFFFDE68A),
  "orange-300": Color(0xFFFCD34D),
  "orange-400": Color(0xFFFBBF24),
  "orange-500": Color(0xFFF59E0B),
  "orange-600": Color(0xFFD97706),
  "orange-700": Color(0xFFB45309),
  "orange-800": Color(0xFF92400E),
  "orange-900": Color(0xFF78350F),
};

// TODO
class EasyOption {
  final Map<String, double> spacing;

  final Map<String, Color> color;

  const EasyOption({
    this.spacing = defaultSpacing,
    this.color = defaultColor,
  });

  const EasyOption.empty()
      : color = defaultColor,
        spacing = defaultSpacing;
}
