import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const KulinerKitaApp());
}

class KulinerKitaApp extends StatelessWidget {
  const KulinerKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KulinerKita',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF26B38),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8F0),
          foregroundColor: Color(0xFF38291F),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
