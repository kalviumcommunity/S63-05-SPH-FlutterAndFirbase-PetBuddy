import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore service responsible for CRUD operations on a `tasks` collection.
class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  /// Creates a new task document for a given user.
  Future<void> addTask({
    required String uid,
    required String title,
  }) async {
    await _db.collection('tasks').add({
      'uid': uid,
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Real-time read using snapshots.
  /// Returns all tasks belonging to the given user.
  Stream<QuerySnapshot<Map<String, dynamic>>> tasksStream(String uid) {
    return _db
        .collection('tasks')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Updates an existing task title.
  Future<void> updateTask({
    required String docId,
    required String uid,
    required String title,
  }) async {
    // Basic update. `uid` can be used for extra validation if needed.
    await _db.collection('tasks').doc(docId).update({
      'title': title,
    });
  }

  /// Deletes a task document by its document id.
  Future<void> deleteTask({
    required String docId,
    required String uid,
  }) async {
    // Basic delete. `uid` can be used for extra validation if needed.
    await _db.collection('tasks').doc(docId).delete();
  }
}

