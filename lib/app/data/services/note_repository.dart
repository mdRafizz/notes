import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/note_model.dart';

class NoteRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Get current user ID
  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    return user.uid;
  }

  /// Reference to a user's notes collection
  CollectionReference<Map<String, dynamic>> get _userNotesRef {
    return _firestore.collection('notes').doc(_uid).collection('userNotes');
  }

  /// Create new note
  Future<void> addNote(NoteModel note) async {
    try {
      await _userNotesRef.doc(note.id).set(note.toJson());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }


  /// Update existing note
  Future<void> updateNote(String noteId, NoteModel note) async {
    try {
      await _userNotesRef.doc(noteId).update(note.toJson());
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  /// Delete existing note
  Future<void> deleteNote(String noteId) async {
    try {
      await _userNotesRef.doc(noteId).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  Stream<List<NoteModel>> getNotes() {
    return _userNotesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return NoteModel.fromJson(doc.data()!);
      }).toList();
    });
  }
}
