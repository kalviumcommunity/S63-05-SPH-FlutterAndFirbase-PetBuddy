import 'package:flutter/material.dart';

import '../widgets/welcome_icon.dart';

/// A simple welcome UI.
/// Includes:
/// - AppBar
/// - Column with title Text, an icon, and a button
/// The button uses `setState()` to update UI (text + color).
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // UI state that changes when the button is pressed.
  bool _isReady = false;

  void _onButtonPressed() {
    // `setState()` triggers Flutter to rebuild this widget's UI using the
    // new values of `_isReady`.
    setState(() {
      _isReady = !_isReady;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget structure:
    // Scaffold
    //  -> AppBar
    //  -> body (Center -> Column -> Text + Icon + Button)
    final buttonText = _isReady ? 'You are Ready!' : 'Click to Start';
    final buttonColor = _isReady ? Colors.green : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'PetBuddy',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const WelcomeIcon(),
              const SizedBox(height: 24),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                  ),
                  onPressed: _onButtonPressed,
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

