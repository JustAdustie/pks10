import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Purple
  static const Color backgroundColor = Color(0xFFD6EAF8); // Light Blue
  static const Color textColor = Colors.white; // White
  static const Color labelColor = Color(0xFF34495E); // Dark Blue
  static const Color textFieldBorderColor = Color(0xFF7D4B87); // Dark Purple
  static const Color buttonBorderColor = Color(0xFFE74C3C); // Red

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(
          color: Color(0xFF9B59B6), // Purple hint text
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: textFieldBorderColor, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: buttonBorderColor, // Red text color for button
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 2, color: buttonBorderColor), // Red border for button
          ),
        ),
      ),
    );
  }
}
