import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static Color primary = const Color(0xFF5D9CEC);
  static Color backgroundColorLight = const Color(0xFFDFECDB);
  static Color backgroundColorDark = const Color(0xFF060E1E);
  static Color green = const Color(0xFF61E757);
  static Color red = const Color(0xFFEC4B4B);
  static Color black = const Color(0xFF141922);
  static Color grey = const Color(0xFFC8C9CB);
  static Color white = const Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundColorLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: grey,
          selectedItemColor: primary),
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: primary,actionsIconTheme: IconThemeData(color: white),
          titleTextStyle: TextStyle(
              color: white, fontWeight: FontWeight.w700, fontSize: 22.sp,fontFamily: 'ElMessiri')),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: grey.withOpacity(0.8),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: primary,
            width: 2.w,
          ))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: primary,

        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
            foregroundColor: AppTheme.black),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: primary,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'ElMessiri',
          fontSize: 16.sp,
          color: black,
        ),
        bodyLarge: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w400,
          color: black,
        ),
        titleMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
          color: black,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(color: white, width: 4.w),
        ),
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundColorDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: grey,
          backgroundColor: black,
          selectedItemColor: primary),
      appBarTheme: AppBarTheme(actionsIconTheme: IconThemeData(color: black),

          elevation: 0,
          backgroundColor: primary,
          titleTextStyle: TextStyle(
              color: backgroundColorDark, fontWeight: FontWeight.w700, fontSize: 22.sp,fontFamily: 'ElMessiri')),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: white.withOpacity(0.5)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: grey.withOpacity(0.8),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary,
                width: 2.w,
              ))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: primary,

        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
            ),
            foregroundColor: AppTheme.black),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'ElMessiri',
          fontSize: 18.sp,
          color: primary,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'ElMessiri',
          fontSize: 16.sp,
          color: white,
        ),
        bodyLarge: TextStyle(
          fontSize: 20.sp,
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.w400,
          color: white,
        ),
        titleMedium: TextStyle(
          fontSize: 24.sp,
          fontFamily: 'ElMessiri',
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(color: black, width: 4.w),
        ),
      ));
}
