import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget for the app.
/// Uses `MaterialApp` and loads the demo screen as `home`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic widget tree structure (simplified):
    // MaterialApp
    //  -> Scaffold
    //      -> AppBar
    //      -> body (includes StatelessWidget and Center->Text)
    //      -> FloatingActionButton (updates Counter via setState)
    return MaterialApp(
      title: 'Flutter Widget Demo',
      home: const CounterExample(),
    );
  }
}

/// StatelessWidget example.
/// Difference:
/// - StatelessWidget has no mutable state (its UI is based on inputs/constructor values).
class StatelessExample extends StatelessWidget {
  final String message; // Null safety: non-nullable.

  const StatelessExample({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // StatelessWidget: no setState, no mutable fields, just returns UI.
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

/// StatefulWidget example (counter).
/// Difference:
/// - StatefulWidget has a `State` object with mutable fields (like `_counter`).
class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  int _counter = 0; // Null safety: int is non-nullable by default.

  void _increment() {
    setState(() {
      // `setState()` triggers UI updates:
      // Flutter rebuilds this State's widgets by calling `build()` again,
      // so the new counter value is shown on screen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless + Stateful Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // StatelessWidget used inside the widget tree.
          const StatelessExample(
            message: 'StatelessWidget example: simple text UI',
          ),
          const SizedBox(height: 16),
          // Center widget with Text (required).
          Center(
            child: Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
      // FloatingActionButton in the StatefulWidget example (required).
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
