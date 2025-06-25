import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontHelper {
  static const String cairoFamily = 'Cairo';

  static TextStyle cairoBold700({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoRegular400({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w400, 
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoLight300({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w300,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoMedium500({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoSemiBold600({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoExtraBold800({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle cairoBlack900({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontFamily: cairoFamily,
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      color: color,
    );
  }
}