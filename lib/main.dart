import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  // Entry point for the app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget tree starts here: MaterialApp -> home -> WelcomeScreen.
    return MaterialApp(
      title: 'PetBuddy Widget Tree Demo',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
