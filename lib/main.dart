import 'package:flutter/material.dart';
import 'screens/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayoutScreen(),
    );
  }
}
