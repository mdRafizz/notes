import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note/app/routes/app_pages.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(18.h),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 21.sp,
                color: Colors.black,
              ),
            ),
            Gap(10.h),
            TextField(
              controller: TextEditingController(text: controller.title.value),
              maxLines: 1,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 25.sp, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
              onChanged: (value) => controller.title.value = value,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: QuillEditor.basic(
                  controller: controller.quillController,

                  config: QuillEditorConfig(
                    disableClipboard: true,
                    placeholder: 'Description',
                  ),
                ),
              ),
            ),
            QuillSimpleToolbar(
              controller: controller.quillController,
              config: QuillSimpleToolbarConfig(
                toolbarSectionSpacing: .1,
                showAlignmentButtons: false,
                showSearchButton: false,
                showLineHeightButton: false,
                showSmallButton: false,
                showLink: false,
                showQuote: false,
                showFontSize: true,
                showLeftAlignment: false,
                showDirection: false,
                showUndo: false,
                showRedo: false,
                showListCheck: false,
                showHeaderStyle: false,
                showSubscript: false,
                showSuperscript: false,
                showStrikeThrough: false,
                showCodeBlock: false,
                showInlineCode: false,
                showFontFamily: true,
                showDividers: false,
                showIndent: false,
                showClearFormat: false,
              ),
            ),
            Gap(12.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.noteModel != null) {
            controller.updateNote(onSuccess: () => context.go(Routes.HOME));
          } else {
            controller.saveNote(onSuccess: () => context.go(Routes.HOME));
          }
        },elevation: 0,
        backgroundColor: const Color(0xff1aa483),
        child: Obx(() {
          if (controller.isLoading.value) {
            return LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 22.sp,
            );
          }
          return Icon(Icons.save_rounded, color: Colors.white, size: 22.sp);
        }),
      ),
    );
  }
}
