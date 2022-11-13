import 'package:flutter/material.dart';

double responsiveWidth(double width) {
  if (width > 420) {
    return 420;
  } else {
    return width - 50;
  }
}

/// [percentage] percentage should be between 0 to 1
double responsiveWidthByPercentage(
    {required BuildContext context, double percentage = 1, String name = ""}) {
  double deviceWidth = MediaQuery.of(context).size.width;

  if (deviceWidth < 650) {
    return deviceWidth;
  } else {
    return deviceWidth * percentage;
  }
}
