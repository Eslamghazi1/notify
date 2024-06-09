import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final design_dark=  ThemeData(
    elevatedButtonTheme:ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
        )// Add padding around the icon
    ),
    primaryColor: bluishClr,
    primarySwatch: Colors.lightGreen,
    appBarTheme:  AppBarTheme(
        backgroundColor: Colors.lightGreen
    ),
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
  );
  static final design_light = ThemeData(
    elevatedButtonTheme:ElevatedButtonThemeData(
     style: ElevatedButton.styleFrom(
       backgroundColor: Colors.lightGreen,
     )// Add padding around the icon
    ),
    appBarTheme:  AppBarTheme(
      backgroundColor: primaryClr
    ),
    primaryColor: primaryClr,
    primarySwatch: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  TextStyle get haedingstyle {
    return TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.white:Colors.black);
  }
  TextStyle get substyle {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode? Colors.white:Colors.black54);
  }
  TextStyle get ministyle {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Get.isDarkMode? Colors.white:Colors.black);
  }
  TextStyle get bodystyle {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.white:Colors.black);
  }
  TextStyle get body2style {
    return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode? Colors.grey[200]:Colors.black);
  }
}