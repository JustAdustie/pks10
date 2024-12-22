import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFD6EAF8); // Light Blue
  static const Color textColor = Color(0xFF2C3E50); // Dark Blue
  static const Color labelColor = Color(0xFF34495E); // Darker Blue

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor), // Dark blue for body text
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: labelColor), // Darker blue for label text
      ),
    );
  }
}
