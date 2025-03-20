import 'package:flutter/material.dart';
import 'package:marti_app/core/theme/app_theme_extension.dart';

extension ThemeContextExtension on BuildContext {
  AppThemeExtension get textStyles =>
      Theme.of(this).extension<AppThemeExtension>()!;
}
