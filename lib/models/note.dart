
import 'package:cloud_firestore/cloud_firestore.dart';

/// Part 1: one note, stored at users/{uid}/notes/{noteId}.
class Note {
  const Note({
    required this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });

  final String id;
  final String title;
  final String body;

  /// Null for a moment after you add a note.
  final DateTime? createdAt;

  factory Note.fromFirestore(String id, Map<String, dynamic> data) {
    final title = data['title'];
    final body = data['body'];
    final createdAt = data['createdAt'];

    if (title is! String || body is! String) {
      throw FormatException('Title and body must be Strings.');
    }

    if (createdAt != null && createdAt is! Timestamp) {
      throw FormatException('createdAt must be a Timestamp.');
    }

    return Note(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
