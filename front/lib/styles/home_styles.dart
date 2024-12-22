import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9B59B6); // Фиолетовый
  static const Color backgroundColor = Color(0xFFD6EAF8); // Светлый голубой
  static const Color textColor = Colors.white; // Белый для основного текста
  static const Color subtitleColor = Color(0xFF34495E); // Темно-синий для подзаголовков
  static const Color priceColor = Color(0xFF2C3E50); // Темно-синий для цены
  static const Color buttonColor = Color(0xFFE74C3C); // Яркий красный для кнопок
  static const Color cardColor = Color(0xFFBB8FCE); // Лавандовый для карточек
  static const double borderRadius = 20.0;
  static const Color appBarColor = Color(0xFF5DADE2);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
      ),
      iconTheme: IconThemeData(color: buttonColor),
    );
  }
}
