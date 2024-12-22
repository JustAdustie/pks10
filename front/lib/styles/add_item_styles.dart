import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFD6EAF8); // Light Blue
  static const Color inputFillColor = Color(0xFFFFFFFF); // White
  static const Color hintTextColor = Color(0xFF7D4B87); // Dark Purple
  static const Color inputFocusBorderColor = Color(0xFF5DADE2); // Sky Blue
  static const Color buttonBackgroundColor = Color(0xFFBB8FCE); // Lavender
  static const Color buttonBorderColor = Color(0xFF9B59B6); // Purple
  static const Color buttonTextColor = Color(0xFFFFFFFF); // White

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: inputFocusBorderColor, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: buttonTextColor,
          backgroundColor: buttonBackgroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 2, color: buttonBorderColor),
          ),
        ),
      ),
    );
  }
}
