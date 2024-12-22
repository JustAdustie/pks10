import 'package:flutter/material.dart';
import 'package:front/pages/navigation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Мороженое',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFEBF5FB)!),
        useMaterial3: true,
      ),
      home: const MyNavigationPage(),
    );
  }
}
