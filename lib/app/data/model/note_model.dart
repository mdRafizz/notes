import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/quill_delta.dart';

class NoteModel {
  final String id;
  final String title;
  final Delta content;
  final DateTime createdAt;
  final DateTime updateAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updateAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: Delta.fromJson(json['content'] ?? []),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updateAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content.toJson(),
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }
}
