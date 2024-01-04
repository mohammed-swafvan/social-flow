import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_flow/theme/custom_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.rubik(color: Colors.white),
      headlineMedium: GoogleFonts.rubik(color: Colors.black),
      headlineSmall: GoogleFonts.rubik(color: Colors.white),
      bodyLarge: GoogleFonts.rubik(color: Colors.black),
      bodyMedium: GoogleFonts.rubik(color: Colors.black),
      titleLarge: GoogleFonts.rubik(color: Colors.black),
      titleMedium: GoogleFonts.rubik(color: Colors.white),
      labelLarge: GoogleFonts.rubik(color: Colors.black),
      labelMedium: GoogleFonts.rubik(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.rubik(color: Colors.white),
      headlineMedium: GoogleFonts.rubik(color: Colors.white),
      headlineSmall: GoogleFonts.rubik(color: Colors.white),
      bodyLarge: GoogleFonts.rubik(color: Colors.white),
      bodyMedium: GoogleFonts.rubik(color: Colors.white),
      titleLarge: GoogleFonts.rubik(color: Colors.white),
      titleMedium: GoogleFonts.rubik(color: Colors.white),
      labelLarge: GoogleFonts.rubik(color: Colors.white),
      labelMedium: GoogleFonts.rubik(color: Colors.white),
    ),
  );
}
