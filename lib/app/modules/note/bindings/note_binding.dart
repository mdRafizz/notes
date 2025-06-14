import 'package:get/get.dart';

import '../../../data/model/note_model.dart';
import '../controllers/note_controller.dart';

class NoteBinding extends Bindings {
  final NoteModel? noteModel;

  NoteBinding({this.noteModel});

  @override
  void dependencies() {
    Get.put<NoteController>( NoteController(noteModel: noteModel),permanent: false);
  }
}
