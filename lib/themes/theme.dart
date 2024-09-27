import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siatab/themes/colors.dart';

class AppTheme {
  static TextStyle body = TextStyle(
      color: AppColor.dark,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2);

  static TextStyle title = TextStyle(
      color: AppColor.primary,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2);

  static TextStyle title2 = TextStyle(
      color: AppColor.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2);

  static TextStyle title3 = TextStyle(
      color: AppColor.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2);

  static TextStyle title4 = TextStyle(
      color: AppColor.white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2);

  static TextStyle medium = TextStyle(
      color: AppColor.dark,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2);

  static TextStyle logo = TextStyle(
    color: AppColor.primary,
    fontSize: 37.75.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );

  static TextStyle caption1 = TextStyle(
    color: AppColor.primary,
    fontSize: 7.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle caption2 = TextStyle(
    color: AppColor.light,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle caption3 = TextStyle(
    color: AppColor.dark,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle caption4 = TextStyle(
    color: AppColor.dark,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextStyle caption5 = TextStyle(
    color: AppColor.dark,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static TextStyle button = TextStyle(
    color: AppColor.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle map = TextStyle(
    color: AppColor.darkLight,
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle map2 = TextStyle(
    color: AppColor.darkLight,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  static TextStyle map3 = TextStyle(
    color: AppColor.primary,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.white,
      fontFamily: "Poppins",
      brightness: Brightness.light,
    );
  }
}
