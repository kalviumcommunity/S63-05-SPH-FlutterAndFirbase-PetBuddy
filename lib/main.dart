import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Stateless root widget for the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetBuddy Welcome',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Stateless root widget for the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetBuddy Welcome',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

/*
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Stateless root widget for the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetBuddy Welcome',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Stateless root widget for the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetBuddy Welcome',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Firebase initialization:
  // `Firebase.initializeApp()` must run before using FirebaseAuth/Firestore.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  // Minimal Firebase Authentication demo:
  // When the user signs up/signs in, Firebase securely stores their account credentials.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _taskTitleController = TextEditingController();
  StreamSubscription<User?>? _authSub;

  String _authMessage = '';
  bool _isBusy = false;
  String? _signedInEmail;

  String _taskMessage = '';
  bool _taskBusy = false;

  /// Firebase Authentication flow:
  /// - `signUp()` creates a user in Firebase Auth.
  /// - `signIn()` signs the user in.
  /// Firebase handles storing credentials securely using the configured Firebase project.

  @override
  void initState() {
    super.initState();
    // Listen to auth changes so the UI reacts when the signed-in user changes.
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _signedInEmail = user?.email;
      });
    });
  }
  void _increment() {
    setState(() {
      // `setState()` triggers UI updates:
      // Flutter rebuilds this State's widgets by calling `build()` again,
      // so the new counter value is shown on screen.
      _counter++;
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _taskTitleController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _authMessage = 'Enter email and password.');
      return;
    }

    setState(() {
      _isBusy = true;
      _authMessage = '';
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      setState(() => _authMessage = 'Sign up successful.');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _authMessage = e.message ?? 'Sign up failed.');
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }

  Future<void> signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _authMessage = 'Enter email and password.');
      return;
    }

    setState(() {
      _isBusy = true;
      _authMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!mounted) return;
      setState(() => _authMessage = 'Signed in successful.');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _authMessage = e.message ?? 'Sign in failed.');
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }

  Future<void> _signOut() async {
    setState(() {
      _isBusy = true;
      _authMessage = '';
    });

    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _authMessage = 'Signed out.';
      });
    } catch (_) {
      setState(() => _authMessage = 'Sign out failed.');
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }

  /// Firestore real-time sync:
  /// - `tasks` is a Firestore collection.
  /// - `addTask()` writes a new document.
  /// - `.snapshots()` returns a stream; when documents change,
  ///   the UI updates automatically via `StreamBuilder`.
  Stream<QuerySnapshot<Map<String, dynamic>>> get tasksStream {
    return FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addTask() async {
    final title = _taskTitleController.text.trim();

    if (title.isEmpty) {
      setState(() => _taskMessage = 'Enter a task title.');
      return;
    }

    setState(() {
      _taskBusy = true;
      _taskMessage = '';
    });

    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      setState(() {
        _taskTitleController.clear();
        _taskMessage = 'Task added.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _taskMessage = 'Failed to add task: $e');
    } finally {
      if (mounted) {
        setState(() => _taskBusy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless + Stateful Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            const SizedBox(height: 24),

            // Minimal auth UI (basic email/password) to save user credentials in Firebase Auth.
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            if (_signedInEmail == null) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isBusy ? null : signUp,
                  child: const Text('Sign Up (Save to Firebase)'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isBusy ? null : signIn,
                  child: const Text('Sign In'),
                ),
              ),
            ] else ...[
              Text(
                'Signed in: $_signedInEmail',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isBusy ? null : _signOut,
                  child: const Text('Sign Out'),
                ),
              ),
            ],

            if (_authMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(_authMessage),
            ],

            const SizedBox(height: 24),

            // Firestore UI:
            // - Add a task
            // - Display real-time tasks using StreamBuilder
            TextField(
              controller: _taskTitleController,
              decoration: const InputDecoration(
                labelText: 'Task title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _taskBusy ? null : addTask,
                child: const Text('Add Task'),
              ),
            ),
            if (_taskMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(_taskMessage),
            ],
            const SizedBox(height: 12),

            // StreamBuilder listens to Firestore snapshots and rebuilds the UI
            // whenever tasks are added/updated/removed.
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: tasksStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Firestore error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('Loading tasks...');
                }

                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Text('No tasks yet.');
                }

                return ListView.builder(
                  itemCount: docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = docs[index].data();
                    final title = data['title'] as String? ?? '';
                    final createdAt = data['createdAt'];
                    String createdAtText = '';
                    if (createdAt is Timestamp) {
                      createdAtText = createdAt.toDate().toString();
                    }

                    return ListTile(
                      title: Text(title),
                      subtitle: createdAtText.isEmpty
                          ? const Text(' ')
                          : Text(createdAtText),
                    );
                  },
                );
              },
            ),
          ],
        ),
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
*/
