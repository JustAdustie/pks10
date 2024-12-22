import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFBB8FCE); // Lavender
  static const Color textColor = Color(0xFF34495E); // Dark Blue
  static const Color labelColor = Color(0xFF7D4B87); // Dark Purple
  static const Color iconColor = Color(0xFF2C3E50); // Dark Teal
  static const Color buttonColor = Color(0xFF5DADE2); // Light Blue

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: iconColor,
        unselectedItemColor: labelColor,
      ),
    );
  }

  static TextStyle get titleStyle {
    return const TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white, // White color for titles
    );
  }

  static TextStyle get sectionTitleStyle {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: textColor, // Dark blue for section titles
    );
  }

  static TextStyle get sectionContentStyle {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textColor, // Dark blue for section content
    );
  }
}
