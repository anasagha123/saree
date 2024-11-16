

import 'package:flutter/material.dart';

class DeviceSize{
  static late double height;
  static late double width;
  static late EdgeInsets padding;

  static const relativeHeight = 800;
  static const relativeWidth = 360;

  static init(BuildContext ctx){
    height = MediaQuery.sizeOf(ctx).height;
    width = MediaQuery.sizeOf(ctx).width;
    padding = MediaQuery.of(ctx).padding;
  }

  static double myHeight(double heightPercentage) => height * (heightPercentage /relativeHeight);

  static double myWidth(double widthPercentage) => width * (widthPercentage / relativeWidth);

}