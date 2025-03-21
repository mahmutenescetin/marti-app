import 'package:flutter/material.dart';
import 'package:marti_app/core/theme/app_colors.dart';
import 'package:marti_app/core/theme/app_theme_extension.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  AppTheme._internal();

  final _baseTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.textPrimary,
  );

  ThemeData get light => ThemeData.light().copyWith(
        extensions: [
          AppThemeExtension(
            h1: _baseTextStyle.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.5,
            ),
            h2: _baseTextStyle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            h3: _baseTextStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
            bodyLarge: _baseTextStyle.copyWith(
              fontSize: 16,
              letterSpacing: 0.5,
            ),
            bodyMedium: _baseTextStyle.copyWith(
              fontSize: 14,
              letterSpacing: 0.25,
            ),
            bodySmall: _baseTextStyle.copyWith(
              fontSize: 12,
              letterSpacing: 0.4,
            ),
            button: _baseTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
            ),
            caption: _baseTextStyle.copyWith(
              fontSize: 12,
              letterSpacing: 0.4,
            ),
          ),
        ],
      );
}
