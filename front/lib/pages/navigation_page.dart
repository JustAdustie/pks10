import 'package:flutter/material.dart';
import 'package:front/pages/favorites_page.dart';
import 'package:front/pages/home_page.dart';
import 'package:front/pages/profile_page.dart';
import 'package:front/pages/cart_page.dart';
import 'package:front/styles/nav_styles.dart';

class MyNavigationPage extends StatefulWidget {
  const MyNavigationPage({super.key});

  @override
  State<MyNavigationPage> createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyFavouritesPage(),
    MyCartPage(),
    MyUserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Избранное"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.bottomNavSelectedColor,
        unselectedItemColor: AppTheme.bottomNavUnselectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
