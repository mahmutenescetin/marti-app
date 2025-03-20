import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.normal);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle withSize(double size) => copyWith(fontSize: size);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withOpacity(opacity));

  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle withLetterSpacing(double spacing) =>
      copyWith(letterSpacing: spacing);
}
