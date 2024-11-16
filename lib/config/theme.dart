import 'dart:math';

import 'package:flutter/material.dart';
import 'package:saree/config/responsive_font.dart';

class MyTheme {
  static const primary = Color(0xFF0002FF);
  static const scondery = Color(0xFFBFBFFF);

  static appTheme(BuildContext context) => ThemeData(
        fontFamily: "Changa",

        dialogBackgroundColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        appBarTheme: const AppBarTheme(color: Colors.white),
        primaryColor: primary,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: primary,
          selectionHandleColor: primary.withAlpha(180),
          cursorColor: primary,
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: primary),
        indicatorColor: primary,
        colorScheme: ColorScheme.fromSwatch(),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1,
    );

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1,
    );
