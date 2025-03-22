import 'package:flutter/material.dart';
import 'package:marti_app/app/common/theme/text/text_constants.dart' show TextConstants;

class TextStyles {
  static final TextStyles _instance = TextStyles._internal();
  factory TextStyles() => _instance;
  TextStyles._internal();

  final _baseStyle = const TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
  );

  TextStyle get h1 => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeH1,
    height: TextConstants.lineHeightH1,
    letterSpacing: TextConstants.letterSpacingH1,
    fontWeight: FontWeight.bold,
  );

  TextStyle get h2 => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeH2,
    height: TextConstants.lineHeightH2,
    letterSpacing: TextConstants.letterSpacingH2,
    fontWeight: FontWeight.bold,
  );

  TextStyle get h3 => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeH3,
    height: TextConstants.lineHeightH3,
    letterSpacing: TextConstants.letterSpacingH3,
    fontWeight: FontWeight.bold,
  );

  TextStyle get bodyLarge => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeBodyLarge,
    height: TextConstants.lineHeightBody,
    letterSpacing: TextConstants.letterSpacingBody,
  );

  TextStyle get bodyMedium => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeBodyMedium,
    height: TextConstants.lineHeightBody,
    letterSpacing: TextConstants.letterSpacingBody,
  );

  TextStyle get bodySmall => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeBodySmall,
    height: TextConstants.lineHeightBody,
    letterSpacing: TextConstants.letterSpacingBody,
  );

  TextStyle get button => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeButton,
    height: TextConstants.lineHeightButton,
    letterSpacing: TextConstants.letterSpacingButton,
    fontWeight: FontWeight.w500,
  );

  TextStyle get caption => _baseStyle.copyWith(
    fontSize: TextConstants.fontSizeCaption,
    height: TextConstants.lineHeightBody,
    letterSpacing: TextConstants.letterSpacingCaption,
  );

  TextStyle withColor(TextStyle style, Color color) => style.copyWith(color: color);
  TextStyle withWeight(TextStyle style, FontWeight weight) => style.copyWith(fontWeight: weight);
  TextStyle withSize(TextStyle style, double size) => style.copyWith(fontSize: size);
}
