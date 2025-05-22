import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/model/note_model.dart';
import '../../../data/services/note_repository.dart';

class NoteController extends GetxController {
  final NoteModel? noteModel;

  NoteController({this.noteModel});

  var isLoading = false.obs;

  final title = ''.obs;
  late QuillController quillController;

  final _repo = NoteRepository();

  @override
  void onInit() {
    super.onInit();

    if (noteModel != null) {
      title.value = noteModel!.title;

      quillController = QuillController(
        document: Document.fromDelta(noteModel!.content),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      title.value = '';
      quillController = QuillController.basic();
    }
  }

  Future<void> saveNote({required VoidCallback onSuccess}) async {
    final contentDelta = quillController.document.toDelta();
    final plainText = quillController.document.toPlainText().trim();
    final trimmedTitle = title.value.trim();

    if (trimmedTitle.isEmpty || plainText.isEmpty) {

      return;
    }

    final note = NoteModel(
      title: trimmedTitle,
      content: contentDelta,
      createdAt: DateTime.now(),
      updateAt: DateTime.now(),
      id: Uuid().v6(),
    );

    try {
      isLoading(true);
      await _repo.addNote(note);

      onSuccess();
    } catch (e) {
      print(e);

    } finally {
      isLoading(false);
    }
  }

  Future<void> updateNote({required VoidCallback onSuccess}) async {
    final contentDelta = quillController.document.toDelta();
    final plainText = quillController.document.toPlainText().trim();
    final trimmedTitle = title.value.trim();

    if (trimmedTitle.isEmpty || plainText.isEmpty) {

      return;
    }

    final note = NoteModel(
      title: trimmedTitle,
      content: contentDelta,
      id: noteModel!.id,
      createdAt: noteModel!.createdAt,
      updateAt: DateTime.now(),
    );

    try {
      isLoading(true);
      await _repo.updateNote(noteModel!.id, note);

      onSuccess();
    } catch (e) {
      print(e);

    } finally {
      isLoading(false);
    }
  }
}
