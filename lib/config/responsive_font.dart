import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, double baseFontSize) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSized = baseFontSize * scaleFactor;

  double lowerLimit = baseFontSize * 0.8;
  double upperLimit = baseFontSize * 1.2;

  return responsiveFontSized.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  switch (width) {
    case < 600:
      return width / 600;
    case < 900:
      return width / 900;
    default:
      return width / 1000;
  }
}
