import 'package:flutter/material.dart';

import 'screens/stateless_stateful_demo.dart';

void main() {
  // Entry point for the app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget tree starts here: MaterialApp -> home -> StatelessStatefulDemoScreen.
    return MaterialApp(
      title: 'PetBuddy Widget Tree Demo',
      debugShowCheckedModeBanner: false,
      home: const StatelessStatefulDemoScreen(),
    );
  }
}
