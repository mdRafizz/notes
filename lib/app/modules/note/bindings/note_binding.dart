import 'package:get/get.dart';

import '../../../data/model/note_model.dart';
import '../controllers/note_controller.dart';

class NoteBinding extends Bindings {

  final NoteModel? noteModel;

  NoteBinding({this.noteModel});
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(
      () => NoteController(
          noteModel: noteModel
      ),
    );
  }
}
