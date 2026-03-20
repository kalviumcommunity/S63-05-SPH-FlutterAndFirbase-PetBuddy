import 'package:flutter/material.dart';

/// Simple icon widget used in the welcome screen.
class WelcomeIcon extends StatelessWidget {
  const WelcomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.pets,
      size: 90,
      color: Colors.orange,
    );
  }
}

