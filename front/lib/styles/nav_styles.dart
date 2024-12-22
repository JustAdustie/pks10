import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFD6EAF8); // Light Blue
  static const Color textColor = Color(0xFFFFFFFF); // White
  static const Color labelColor = Color(0xFF34495E); // Dark Blue
  static const Color bottomNavSelectedColor = Color(0xFF2C3E50); // Dark Navy
  static const Color bottomNavUnselectedColor = Color(0xFF9B59B6); // Purple

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: bottomNavSelectedColor,
        unselectedItemColor: bottomNavUnselectedColor,
      ),
    );
  }
}
