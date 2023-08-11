import 'package:flutter/material.dart';
import 'package:fundfolio/utils/widget_themes/elevated_button_theme.dart';
import 'package:fundfolio/utils/widget_themes/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/constants.dart';

class GAppTheme {
  GAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GTextTheme.lightTextTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: fontLight,
      selectedIconTheme: IconThemeData(color: secondaryDark),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedItemColor: secondaryDark,
      unselectedItemColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        color: Colors.black26,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: GoogleFonts.poppins(
        color: Colors.black26,
        fontSize: fontSizeTitle,
        fontWeight: FontWeight.w500,
      ),
      labelColor: Colors.black26,
    ),
    elevatedButtonTheme: gElevatedButtonTheme.lightElevatedButtonTheme,
    dataTableTheme: DataTableThemeData(
      headingRowColor: MaterialStateProperty.all(secondaryDark),
      headingTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      dataTextStyle: GoogleFonts.poppins(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      columnSpacing: 2,
      dataRowHeight: 45,
      headingRowHeight: 40,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: GTextTheme.darkTextTheme,
    scaffoldBackgroundColor: Colors.black26,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: secondaryDark),
      unselectedIconTheme: IconThemeData(color: Colors.white60),
      selectedItemColor: secondaryDark,
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.shifting,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        color: fontSubHeading,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    elevatedButtonTheme: gElevatedButtonTheme.darkElevatedButtonTheme,
    tabBarTheme: TabBarTheme(
      labelStyle: GoogleFonts.poppins(
        color: fontSubHeading,
        fontSize: fontSizeTitle,
        fontWeight: FontWeight.w500,
      ),
      labelColor: fontSubHeading,
    ),
    dataTableTheme: DataTableThemeData(
      headingRowColor: MaterialStateProperty.all(secondaryDark),
      headingTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      dataTextStyle: GoogleFonts.poppins(
        color: fontSubHeading,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      columnSpacing: 2,
      dataRowHeight: 45,
      headingRowHeight: 40,
    ),
  );
}
