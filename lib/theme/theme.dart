import 'package:flutter/material.dart';

class AppColors {
  // Paleta de cores do app
  static const Color primary = Color(0xFF51322F); // marrom escuro
  static const Color secondary = Color(0xFFDD8352); // laranja queimado
  static const Color background = Color(0xFFF3EADA); // bege claro
  static const Color surface = Color(0xFFFFC8A9); // pêssego
  static const Color error = Color(0xFFB00020);

  // Contraste das cores
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;
}

class AppTheme {
  static const String fontFamily = 'Roboto';

  static final TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
  ).apply(fontFamily: fontFamily);

  // Tema claro
  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
  );

  // Tema escuro
  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: Colors.black,
    surface: const Color(0xFF1E1E1E),
    onSurface: Colors.white70,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    colorScheme: _lightColorScheme,
    fontFamily: fontFamily,
    textTheme: _textTheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightColorScheme.secondary,
        foregroundColor: _lightColorScheme.onSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: _textTheme.labelLarge,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    colorScheme: _darkColorScheme,
    fontFamily: fontFamily,
    textTheme: _textTheme.apply(
      bodyColor: _darkColorScheme.onSurface,
      displayColor: _darkColorScheme.onSurface,
    ),
    scaffoldBackgroundColor: _darkColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.surface,
      foregroundColor: _darkColorScheme.onSurface,
      centerTitle: true,
    ),
  );
}
