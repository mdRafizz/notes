import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/widgets/reusable_text1.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          context.replace(user != null ? Routes.HOME : Routes.LOGIN);
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/notes_logo.json',
              width: 220.w,
              height: 220.h,
            ),
            Positioned(
              bottom: 45.h,
              child: ReusableText1(
                'Welcome to Notes',
                weight: FontWeight.bold,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
