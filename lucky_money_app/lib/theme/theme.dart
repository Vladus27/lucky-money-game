import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData casinoTheme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB11226), // casino red (brand core)
    brightness: Brightness.light,

    primary: const Color(0xFFB11226), // AppBar, BottomBar, primary actions
    onPrimary: const Color(0xFFFFFFFF),

    secondary: const Color(0xFFF5C542), // gold (CTA, multipliers)
    onSecondary: const Color(0xFF1C1C1C),

    tertiary: const Color(0xFF1DB954), // win / success
    onTertiary: const Color(0xFFFFFFFF),

    error: const Color(0xFFD32F2F), // bombs / lose
    onError: const Color(0xFFFFFFFF),

    surface: const Color(0xFFF7F7F7), // cards, containers
    onSurface: const Color(0xFF1C1C1C),
  ),

  scaffoldBackgroundColor: const Color(0xFFFFFFFF),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFB11226),
    foregroundColor: Colors.white,

    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF5C542),
      foregroundColor: const Color(0xFF1C1C1C),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: Color.fromARGB(255, 150, 15, 33), // gold
        width: 0,
      ),

      backgroundColor: const Color.fromARGB(255, 150, 15, 33),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w600),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w400),
    ),
  ),

  textTheme: GoogleFonts.montserratAlternatesTextTheme().copyWith(
    titleLarge: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w700),
    labelLarge: GoogleFonts.montserratAlternates(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.montserratAlternates(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFF5C542),
    ),
    labelSmall: GoogleFonts.montserratAlternates(
      // fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFB11226),
    selectedItemColor: Color(0xFFF5C542),
    unselectedItemColor: Color(0xB3FFFFFF),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
  ),
);
