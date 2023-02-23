import 'package:flutter/material.dart';
import '../shared/colors.dart';

class ThemeTextStyle {
  static const TextStyle heading18 = BaseTextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static const TextStyle heading16 = BaseTextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle heading15 = BaseTextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  static const TextStyle heading14 = BaseTextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle heading13 = BaseTextStyle(fontSize: 13, fontWeight: FontWeight.w600);
  static const TextStyle heading13Blue = BaseTextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColor.blueTag);
  static const TextStyle heading14White = BaseTextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.white);
  static const TextStyle heading12 = BaseTextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  static const TextStyle body16 = BaseTextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static const TextStyle body15 = BaseTextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static const TextStyle body14 = BaseTextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle body13 = BaseTextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  static const TextStyle body13Bold = BaseTextStyle(fontSize: 13, fontWeight: FontWeight.w600);
  static const TextStyle body13Tag = BaseTextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColor.blueTag);
  static const TextStyle body12 = BaseTextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  static const TextStyle body12White = BaseTextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColor.white);
  static const TextStyle body11 = BaseTextStyle(fontSize: 11, fontWeight: FontWeight.w400);

  static TextStyle hintText14 = BaseTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.black.withOpacity(0.2));
}

class BaseTextStyle extends TextStyle {
  const BaseTextStyle({double? fontSize, FontWeight? fontWeight, Color? color})
    : super(
      fontSize: fontSize ?? 14,
      fontFamily: "Roboto",
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? AppColor.black,
    );
}