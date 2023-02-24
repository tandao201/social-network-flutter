import 'package:flutter/material.dart';

class AppColor {
  static const Color black = Color(0xff262626);
  static const Color white = Color(0xffffffff);
  static const Color lightGrey1 = Color(0xffe1e1e1);
  static const Color blueTag = Color(0xff3797EF);
  static const Color blueDark = Color(0xff121212);
  static Color lightGrey = black.withOpacity(0.1);
  static Color transparent = Colors.transparent;
  static const Color red = Colors.red;
  static Color grey = black.withOpacity(0.5);

  static const gradientPrimary = LinearGradient(colors: [
      Color(0xffFBAA47),
      Color(0xffD91A46),
      Color(0xffA60F93),
  ]);

  static const gradientReaded = LinearGradient(colors: [
    Color(0xff8a8a8a),
    Color(0xffbebebe),
  ]);
}