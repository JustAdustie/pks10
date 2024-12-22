import 'package:flutter/material.dart';

class CartPageTheme {
  static const Color backgroundColor = Color(0xFFD6EAF8); // Светлый голубой фон
  static const Color appBarColor = Color(0xFF5DADE2); // Яркий синий для AppBar
  static const Color appBarTextColor = Colors.white; // Белый цвет для текста в AppBar
  static const Color buttonColor = Color(0xFF9B59B6); // Фиолетовый для кнопок
  static const Color priceTextColor = Color(0xFF2C3E50); // Темный синий для цены
  static const Color quantityButtonColor = Color(0xFF7D4B87); // Темный фиолетовый для кнопок количества

  static const TextStyle appBarTextStyle = TextStyle(
    color: appBarTextColor,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle priceTextStyle = TextStyle(
    fontSize: 14,
    color: priceTextColor,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle quantityTextStyle = TextStyle(
    fontSize: 14,
    color: priceTextColor,
    fontWeight: FontWeight.w500,
  );

  static ButtonStyle buttonStyle = TextButton.styleFrom(
    backgroundColor: buttonColor,
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
}
