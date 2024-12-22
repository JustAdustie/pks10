import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Фиолетовый
  static const Color backgroundColor = Color(0xFFD6EAF8); // Светлый голубой
  static const Color textColor = Colors.white; // Белый
  static const Color labelColor = Color(0xFF34495E); // Темно-синий
  static const Color inputFieldBackgroundColor = Color(0xFFBB8FCE); // Лавандовый
  static const Color inputBorderColor = Color(0xFF7D4B87); // Темный фиолетовый

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
    );
  }

  static InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: inputFieldBackgroundColor,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9B59B6), // Фиолетовый для подсказок
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
        borderSide: const BorderSide(color: inputBorderColor, width: 1),
      ),
    );
  }

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: const Color(0xFFE74C3C), // Яркий красный для текста
    backgroundColor: const Color(0xFFBB8FCE), // Лавандовый фон
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(width: 2, color: Color(0xFFE74C3C)), // Красный для границы
    ),
  );
}
