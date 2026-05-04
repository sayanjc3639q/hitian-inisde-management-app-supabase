import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color maroon = Color(0xFF800000);
  static const Color cream = Color(0xFFFFFDD0);
  static const Color darkMaroon = Color(0xFF4A0000);
  static const Color lightCream = Color(0xFFFFF9E5);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: maroon,
        primary: maroon,
        secondary: cream,
        surface: lightCream,
        onPrimary: Colors.white,
        onSecondary: maroon,
      ),
      scaffoldBackgroundColor: lightCream,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: maroon,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: maroon,
        primary: maroon,
        secondary: cream,
        brightness: Brightness.dark,
        surface: const Color(0xFF1A1A1A),
        onPrimary: Colors.white,
        onSecondary: maroon,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkMaroon,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: cream,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF1A1A1A),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
