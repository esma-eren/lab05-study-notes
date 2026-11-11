
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/note.dart';

/// Part 3: the notes of one user in Cloud Firestore.
class NotesRepository {
  NotesRepository(this._db);

  final FirebaseFirestore _db;

  /// The notes collection of one user.
  CollectionReference<Map<String, dynamic>> _notes(String uid) =>
      _db.collection('users').doc(uid).collection('notes');

  /// Live list of the user's notes, newest first.
  Stream<List<Note>> watchNotes(String uid) {
    return _notes(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  /// Adds a note.
  Future<void> addNote(String uid, String title, String body) async {
    final trimmedTitle = title.trim();
    final trimmedBody = body.trim();

    if (trimmedTitle.isEmpty || trimmedTitle.length > 100) {
      throw ArgumentError(
        'Title must be between 1 and 100 characters.',
      );
    }

    await _notes(uid).add({
      'title': trimmedTitle,
      'body': trimmedBody,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String uid, String noteId) async {
    await _notes(uid).doc(noteId).delete();
  }
}
