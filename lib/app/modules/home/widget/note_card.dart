import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:note/app/data/model/note_model.dart';
import 'package:note/app/data/services/note_repository.dart';
import 'package:note/app/routes/app_pages.dart';

import '../../../widgets/reusable_text1.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.NOTE, extra: note);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
        margin: EdgeInsets.only(bottom: 17.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 10,
              spreadRadius: -2,
              color: Colors.black.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText1(
                    note.title,
                    size: 17,
                    family: 'serif',
                    weight: FontWeight.w500,
                  ),
                  Gap(8.h),
                  Text(
                    Document.fromDelta(note.content).toPlainText(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  NoteRepository().deleteNote(note.id);
                },
                icon: Icon(Icons.delete, color: Colors.red, size: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
