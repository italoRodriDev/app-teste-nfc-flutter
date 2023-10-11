import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  dynamic textAlign;
  String value;
  bool? inherit;
  Color? color;
  Color? backgroundColor;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  double? letterSpacing;
  double? wordSpacing;
  TextBaseline? textBaseline;
  double? height;
  TextLeadingDistribution? leadingDistribution;
  Locale? locale;
  Paint? foreground;
  Paint? background;
  List<Shadow>? shadows;
  TextDecoration? decoration;
  Color? decorationColor;
  TextDecorationStyle? decorationStyle;
  double? decorationThickness;
  String? debugLabel;
  String? fontFamily;
  List<String>? fontFamilyFallback;
  String? package;
  TextOverflow? overflow;

  TextComponent(
      {Key? key,
      required this.value,
      this.inherit,
      this.color,
      this.backgroundColor,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.letterSpacing,
      this.wordSpacing,
      this.textBaseline,
      this.height,
      this.leadingDistribution,
      this.locale,
      this.foreground,
      this.background,
      this.shadows,
      this.decoration,
      this.decorationColor,
      this.decorationStyle,
      this.decorationThickness,
      this.debugLabel,
      this.fontFamily,
      this.fontFamilyFallback,
      this.package,
      this.overflow,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value,
        textAlign: textAlign,
        style: TextStyle(
            inherit: true,
            color: color,
            backgroundColor: backgroundColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing));
  }
}
