import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note/app/data/services/note_repository.dart';
import 'package:note/app/modules/home/controllers/home_controller.dart';
import 'package:note/app/modules/home/widget/note_card.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/widgets/reusable_text1.dart';

import '../../../data/model/note_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              stretch: true,
              backgroundColor: CupertinoColors.systemGrey6,
              elevation: 0,
              expandedHeight: 150.h,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(
                  left: 17.w,
                  bottom: 65.h,
                  right: 17.w,
                ),
                title: Row(
                  children: [
                    ReusableText1(
                      'Your Notes',
                      size: 25,
                      weight: FontWeight.bold,
                      family: 'serif',
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.signOut(
                          onSuccess: () => context.go(Routes.LOGIN),
                        );
                      },
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return Container(
                            height: 23.h,
                            width: 23.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: LoadingAnimationWidget.inkDrop(
                              color: Colors.white,
                              size: 10.sp,
                            ),
                          );
                        } else {
                          return Image.asset(
                            'assets/images/logout.png',
                            width: 23.w,
                            height: 23.h,
                            fit: BoxFit.scaleDown,
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(65.h),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(17.w, 0.h, 17.w, 10.h),
                  child: SizedBox(
                    height: 42.h,
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search your notes',
                        prefixIcon: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey.shade700,
                          size: 19.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 10.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            StreamBuilder<List<NoteModel>>(
              stream: NoteRepository().getNotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                }

                final notes = snapshot.data ?? [];

                if (notes.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: Text('No notes found')),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 12.h,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final note = notes[index];
                      return NoteCard(note: note);
                    }, childCount: notes.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.push(Routes.NOTE, extra: null);
            },
            backgroundColor: Colors.black,
            elevation: 0,
            child: Icon(Icons.add, color: Colors.white, size: 28.sp),
          ),
          Gap(40.h),
        ],
      ),
    );
  }
}
