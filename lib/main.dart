import 'package:flutter/material.dart';
import 'package:ruolette_game/spinn.dart';
import 'package:ruolette_game/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roulette Game',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.orange, 
        scaffoldBackgroundColor: Colors.black, // Background color for UI elements
        cardColor: Colors.black, // Background color for cards
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Default text color
          bodyMedium: TextStyle(color: Colors.white), // Secondary text color
          titleLarge: TextStyle(color: Color(0xffFFD700)), // Text color for app bar title
        ), colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xffFFD700), 
    ).copyWith(background: Colors.black),
      ),
      home: const SplashPage(),
    );
  }
}
