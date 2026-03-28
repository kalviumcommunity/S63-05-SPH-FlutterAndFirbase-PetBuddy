import 'package:flutter/material.dart';

/// **StatelessWidget**: UI that does not store mutable state.
/// `build()` runs once per parent rebuild; the widget itself cannot call `setState()`.
/// Use for static labels, icons, or layouts that only depend on constructor arguments.
class DemoStaticHeader extends StatelessWidget {
  const DemoStaticHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Static part: title never changes from inside this widget.
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        'Stateless header (does not change)',
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.w600,
          color: Colors.blueAccent, // UI change for Hot Reload demo
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// **StatefulWidget**: UI that can change over time using internal state.
/// The `State` object holds fields like `_counter` and calls `setState()` to refresh the UI.
class StatelessStatefulDemoScreen extends StatefulWidget {
  const StatelessStatefulDemoScreen({super.key});

  @override
  State<StatelessStatefulDemoScreen> createState() =>
      _StatelessStatefulDemoScreenState();
}

class _StatelessStatefulDemoScreenState
    extends State<StatelessStatefulDemoScreen> {
  // Dynamic part: only the StatefulWidget’s State can own this and update it.
  int _counter = 0;

  void _increment() {
    // Added debugPrint to demonstrate Debug Console logs
    debugPrint('Button clicked! Counter changing to ${_counter + 1}');

    // `setState()` tells Flutter to re-run `build()` for this widget subtree
    // so Text and Button reflect the new `_counter`.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget hierarchy: Scaffold → body Column → [Stateless header | dynamic Text | Button]
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DemoStaticHeader(),
              Text(
                'Counter (dynamic): $_counter',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _increment,
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
