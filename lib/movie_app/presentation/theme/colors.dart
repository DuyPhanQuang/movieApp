import 'package:flutter/material.dart';

class AppColor {
  AppColor._();
  static const int _bluePrimaryValue = 0xFF314DD3;
  static const Color blue1 = Color(0xFFEAEDFB);
  static const Color blue4 = Color(0xFF6F82E0);
  static const Color blue50 = Color(0xFFDCE4FF);
  static const Color blue100 = Color(0xFFDCE4FF);
  static const Color blue200 = Color(0xFFADBFFF);
  static const Color blue300 = Color(0xFF738AFF);
  static const Color blue400 = Color(0xFF314DD3);
  static const Color blue500 = Color(0xFF25337D);
  static const Color blue600 = Color(0xFF1F2846);
  static const Color blue700 = Color(0xFF00214D);
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: blue50,
      100: blue100,
      200: blue200,
      300: blue300,
      400: blue400,
      500: blue500,
      600: blue600,
      700: blue700,
    },
  );

  static const Color black1S = Color(0xFFF1F1F1);
  static const Color black2S = Color(0xFFCCCCCC);
  static const Color black3S = Color(0xFF999999);
  static const Color black3 = Color.fromRGBO(51, 51, 51, 0.5);
  static const Color black7 = Color.fromRGBO(51, 51, 51, 0.7);
  static const Color black4S = Color(0xFF666666);
  static const Color black5 = Color(0xFF333333);
  static const Color black400 = Color(0xFF404040);
  static const Color black = Colors.black;
  static const Color background2 = Color(0xFF0A0A0A);
  static const Color white = Colors.white;
  static const Color blackBaseSkeletonColor = black;
  static const Color blackHighLightSkeletonColor = Color(0x0D000000);
  static const Color backgroundLight = Color(0xFFF5F6FD);
  static const Color appBackground = Color(0xFFDEE4E7);
  static const Color mainColor = Color(0xFF666666);
}
