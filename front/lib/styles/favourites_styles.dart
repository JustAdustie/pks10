import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFD6EAF8); // Light Blue
  static const Color textColor = Colors.white; // White text
  static const Color labelColor = Color(0xFF34495E); // Dark Blue
  static const Color appBarColor = Color(0xFF5DADE2); // Bright Blue

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
