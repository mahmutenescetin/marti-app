import 'package:flutter/material.dart';
import 'package:marti_app/core/theme/app_theme_extension.dart';

extension ContextExtension on BuildContext {
  AppThemeExtension get textStyles =>
      Theme.of(this).extension<AppThemeExtension>()!;

  ColorScheme get colors => Theme.of(this).colorScheme;

  Color get primaryColor => colors.primary;

  Color get secondaryColor => colors.secondary;

  Color get backgroundColor => colors.surface;

  Color get surfaceColor => colors.surface;

  Color get errorColor => colors.error;

  Color get textPrimaryColor => colors.onSurface;

  Color get textSecondaryColor => colors.onSurface;

  Color get dividerColor => colors.outline;
}
