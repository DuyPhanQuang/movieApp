import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/constant/constant.dart';
import 'colors.dart';

export 'colors.dart';

const _kFontFamily = 'Roboto';

/// early...still missing many theme props setting.
class MovieAppTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: Fonts.s_15,
      fontWeight: FontWeight.w500,
      height: Dimens.p_20 / Dimens.p_16,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: Fonts.s_15,
      fontWeight: FontWeight.w500,
      height: Dimens.p_24 / Dimens.p_18,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    titleLarge: TextStyle(
      fontSize: Fonts.s_20,
      fontWeight: FontWeight.w500,
      height: Dimens.p_30 / Dimens.p_20,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    labelLarge: TextStyle(
      fontSize: Fonts.s_12,
      fontWeight: FontWeight.w500,
      height: Dimens.p_18 / Dimens.p_12,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: Fonts.s_15,
      fontWeight: FontWeight.w500,
      height: Dimens.p_20 / Dimens.p_16,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: Fonts.s_15,
      fontWeight: FontWeight.w500,
      height: Dimens.p_24 / Dimens.p_18,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    titleLarge: TextStyle(
      fontSize: Fonts.s_20,
      fontWeight: FontWeight.w500,
      height: Dimens.p_30 / Dimens.p_20,
      color: AppColor.black5,
      fontFamily: _kFontFamily,
    ),
    labelLarge: TextStyle(
      fontSize: Fonts.s_12,
      fontWeight: FontWeight.w500,
      height: Dimens.p_18 / Dimens.p_12,
      color: AppColor.white,
      fontFamily: _kFontFamily,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      fontFamily: _kFontFamily,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.black;
        }),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      scaffoldBackgroundColor: AppColor.appBackground,
      textTheme: lightTextTheme,
      primaryColor: AppColor.blue,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      fontFamily: _kFontFamily,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: darkTextTheme,
    );
  }
}

extension MovieAppTextStyleExt on ThemeData {
  TextStyle get appLoading => textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColor.blue,
      );

  TextStyle get headerTitle => textTheme.titleLarge!.copyWith(
        color: AppColor.background2.withAlpha(70),
      );

  TextStyle get buttonTitle => textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColor.mainColor,
      );
}
