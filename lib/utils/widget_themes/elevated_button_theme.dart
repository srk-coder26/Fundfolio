// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

/*-- Light and Dark Elevated Button Themes --*/

class gElevatedButtonTheme {
  gElevatedButtonTheme._(); // To Avoid create instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryDark,
      foregroundColor: gCardBgColor,
      side: BorderSide(color: secondaryDark),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryDark,
      foregroundColor: gCardBgColor,
      side: BorderSide(color: secondaryDark),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    ),
  );
}