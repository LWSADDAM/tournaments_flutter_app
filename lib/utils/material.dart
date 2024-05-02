import 'package:flutter/material.dart';

class MaterialColors {
  static const int maincolor = 0xFF0003AF;

  static const MaterialColor primaryColor = MaterialColor(
    maincolor,
    <int, Color>{
      50: Color.fromARGB(255, 238, 230, 255),
      100: Color.fromARGB(255, 212, 186, 255),
      200: Color.fromARGB(255, 166, 108, 255),
      300: Color.fromARGB(255, 86, 14, 236),
      400: Color.fromARGB(255, 53, 0, 194),
      500: Color(maincolor),
      600: Color.fromARGB(255, 36, 0, 133),
      700: Color.fromARGB(255, 26, 0, 92),
      800: Color.fromARGB(255, 17, 0, 59),
      900: Color.fromARGB(255, 0, 0, 0),
    },
  );

  static const MaterialColor forDarkPrimaryColor = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      50: Color(0xFFF3E5F5),
      100: Color(0xFFE1BEE7),
      200: Color(0xFFCE93D8),
      300: Color(0xFFBA68C8),
      400: Color(0xFFAB47BC),
      500: Color(_purplePrimaryValue),
      600: Color(0xFF8E24AA),
      700: Color(0xFF7B1FA2),
      800: Color(0xFF6A1B9A),
      900: Color(0xFF4A148C),
    },
  );
  static const int _purplePrimaryValue = 0xFFF1A0FF;
}
