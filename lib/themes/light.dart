import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,

    primary: const Color.fromARGB(255, 21, 190, 119),
    onPrimary: const Color.fromARGB(199, 246, 252, 249),

    onSecondary: const Color.fromARGB(255, 0, 255, 179),

    surface: const Color.fromARGB(255, 241, 244, 248),

    outlineVariant: const Color.fromARGB(255, 232, 236, 244),

    // ···
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    headlineLarge:
        GoogleFonts.outfit(fontSize: 40, fontWeight: FontWeight.w600),
    headlineMedium:
        GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.w600),
    headlineSmall:
        GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.sora(fontSize: 17, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.sora(fontSize: 14, fontWeight: FontWeight.w400),
  ),
);
