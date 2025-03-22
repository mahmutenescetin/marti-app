import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle button;
  final TextStyle caption;

  const AppThemeExtension({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.button,
    required this.caption,
  });

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? button,
    TextStyle? caption,
  }) {
    return AppThemeExtension(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      button: button ?? this.button,
      caption: caption ?? this.caption,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}
