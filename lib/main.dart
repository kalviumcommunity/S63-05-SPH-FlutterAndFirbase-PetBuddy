import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/pets_provider.dart';
import 'providers/walks_provider.dart';
import 'providers/request_provider.dart';
import 'providers/activity_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PetsProvider()),
        ChangeNotifierProvider(create: (_) => WalksProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ],
      child: const PetBuddyApp(),
    ),
  );
import 'screens/responsive_layout.dart';
import 'screens/scrollable_views.dart';
import 'screens/user_input_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Assignments',
      debugShowCheckedModeBanner: false,
      home: const AssignmentOverviewScreen(),
    );
  }
}

class AssignmentOverviewScreen extends StatelessWidget {
  const AssignmentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Assignments Hub')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.desktop_mac),
            title: const Text('1. Responsive Layout'),
            subtitle: const Text('MediaQuery, Expanded, Row, Column'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResponsiveLayoutScreen()),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('2. Scrollable Views'),
            subtitle: const Text('ListView.builder & GridView.builder'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScrollableViewsScreen()),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('3. User Input Form'),
            subtitle: const Text('TextField, Validation & SnackBar'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserInputFormScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
