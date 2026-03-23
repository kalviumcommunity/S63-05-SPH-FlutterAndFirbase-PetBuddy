import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';

/// A simple dashboard that shows Firestore data in real-time using `StreamBuilder`.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.uid,
    required this.email,
  });

  final String uid;
  final String email;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _taskController = TextEditingController();
  final _auth = AuthService();
  final _firestore = FirestoreService();

  String _actionMessage = '';

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  /// Create (add) a new task document for this user.
  Future<void> _addTask() async {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    setState(() => _actionMessage = '');

    try {
      await _firestore.addTask(uid: widget.uid, title: title);
      // Clear input after success.
      if (!mounted) return;
      setState(() {
        _taskController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _actionMessage = e.toString());
    }
  }

  Future<void> _updateTaskTitle({
    required String docId,
    required String currentTitle,
  }) async {
    final newTitle = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        final controller = TextEditingController(text: currentTitle);
        return AlertDialog(
          title: const Text('Update Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Task title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newTitle == null || newTitle.isEmpty) return;

    try {
      await _firestore.updateTask(
        docId: docId,
        uid: widget.uid,
        title: newTitle,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _actionMessage = e.toString());
    }
  }

  Future<void> _deleteTask(String docId) async {
    try {
      await _firestore.deleteTask(docId: docId, uid: widget.uid);
    } catch (e) {
      if (!mounted) return;
      setState(() => _actionMessage = e.toString());
    }
  }

  Future<void> _logout() async {
    await _auth.logout();

    // Navigate back to login screen.
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome: ${widget.email}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add Task'),
                ),
              ),
              if (_actionMessage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(_actionMessage),
              ],
              const SizedBox(height: 16),

              // Firestore real-time updates:
              // - `tasksStream(uid)` returns a stream from `.snapshots()`.
              // - `StreamBuilder` rebuilds automatically when tasks change.
              Expanded(
                child: StreamBuilder(
                  stream: _firestore.tasksStream(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Firestore error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Loading tasks...'));
                    }

                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return const Center(child: Text('No tasks yet.'));
                    }

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        final data = doc.data();
                        final title = data['title'] as String? ?? '';

                        return ListTile(
                          title: Text(title),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              IconButton(
                                tooltip: 'Edit',
                                onPressed: () => _updateTaskTitle(
                                  docId: doc.id,
                                  currentTitle: title,
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                onPressed: () => _deleteTask(doc.id),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Basic hint to use uid if required.
              Text(
                'Signed in uid: ${widget.uid}',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              // Avoid unused variable warning if `currentUser` isn't used elsewhere.
              // (Not required for UI logic.)
              if (currentUser == null) const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

