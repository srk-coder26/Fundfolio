import 'package:flutter/material.dart';
import 'package:fundfolio/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class GTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    // Account Value Text
    headlineMedium: GoogleFonts.concertOne(
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    // Top App bar App Name
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    // Account Value Sub Text
    bodyMedium: GoogleFonts.poppins(
      color: fontSubHeading,
      fontWeight: FontWeight.w500,
    ),
    // Returns Card Value Text
    titleLarge: GoogleFonts.montserrat(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    // All Instruments Text
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: fontHeading,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: fontSubHeading,
    ),

    bodySmall: GoogleFonts.poppins(
      color: fontHeading,
      fontWeight: FontWeight.w400,
    ),

    // List Tile Names
    bodyLarge: GoogleFonts.poppins(
      color: fontHeading,
      fontSize: fontSizeTitle,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    // Account Value Text
    headlineMedium: GoogleFonts.concertOne(
      fontWeight: FontWeight.w600,
      color: fontSubHeading,
      fontSize: 28,
    ),
    
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: secondaryDark,
    ),
    // Account Value Sub Text
    bodyMedium: GoogleFonts.poppins(
      color: fontSubHeading,
      fontWeight: FontWeight.w500,
    ),
    // Returns Card Value Text
    titleLarge: GoogleFonts.montserrat(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    // All Instruments Text
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: fontSubHeading,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      color: fontSubHeading,
    ),

    // List Tile Names
    bodyLarge: GoogleFonts.poppins(
      color: fontSubHeading,
      fontSize: fontSizeTitle,
      fontWeight: FontWeight.w500,
    ),
    bodySmall:
        GoogleFonts.poppins(color: fontSubHeading, fontWeight: FontWeight.w400),
  );
}
