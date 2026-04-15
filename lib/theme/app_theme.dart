import 'package:flutter/material.dart';

class AppTheme {
  static const Color bordeaux = Color(0xFF7A1E2B);
  static const Color lightBeige = Color(0xFFF5E9D8);
  static const Color softGold = Color(0xFFD7B779);
  static const Color anthracite = Color(0xFF262626);
  static const Color cardBackground = Color(0xFFFFF8EF);
  static const Color darkSurface = Color(0xFF3D1118);
  static const Color darkCard = Color(0xFF561923);
  static const Color darkText = Color(0xFFF5E9D8);

  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      colorScheme: const ColorScheme.light(
        primary: bordeaux,
        secondary: softGold,
        surface: cardBackground,
        onPrimary: Colors.white,
        onSecondary: anthracite,
        onSurface: anthracite,
      ),
      scaffoldBackgroundColor: lightBeige,
      appBarTheme: const AppBarTheme(
        backgroundColor: bordeaux,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bordeaux,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softGold),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softGold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: bordeaux, width: 1.6),
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: anthracite,
          letterSpacing: 0.3,
        ),
        titleLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: anthracite,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: anthracite,
          height: 1.45,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        primary: softGold,
        secondary: bordeaux,
        surface: darkCard,
        onPrimary: anthracite,
        onSecondary: darkText,
        onSurface: darkText,
      ),
      scaffoldBackgroundColor: darkSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF5D1722),
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: softGold,
          foregroundColor: anthracite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF6C202D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softGold),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softGold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softGold, width: 1.6),
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: darkText,
          letterSpacing: 0.3,
        ),
        titleLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: darkText,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: darkText,
          height: 1.45,
        ),
      ),
    );
  }
}
