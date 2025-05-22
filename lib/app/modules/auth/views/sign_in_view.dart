import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note/app/modules/auth/controllers/auth_controller.dart';
import 'package:note/app/routes/app_pages.dart';
import 'package:note/app/widgets/reusable_text1.dart';

import '../widgets/custom_input_field.dart';

class SignInView extends GetView<AuthController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(130.h),
            Image.asset('assets/images/notes.png', width: 80.h, height: 80.h),
            Gap(30.h),
            ReusableText1('Welcome Back', size: 25, weight: FontWeight.w600),
            Gap(70.h),

            CustomInputField(
              controller: controller.email,
              keyboard: TextInputType.emailAddress,
              hintText: 'Enter your email',
              prefixIcon: Icons.email_rounded,
            ),
            Gap(40.h),

            Obx(
              () => CustomInputField(
                controller: controller.password,
                hintText: 'Enter your password',
                prefixIcon: Icons.password,
                obscureText: controller.loginObscureText.value,
                hasToggleVisibility: true,
                onSuffixTap: () => controller.loginObscureText.toggle(),
                suffixVisibleIcon: Icons.visibility_rounded,
                suffixHiddenIcon: Icons.visibility_off_rounded,
              ),
            ),

            Gap(50.h),
            MaterialButton(
              onPressed: () {
                controller.login(onSuccess: () => context.go(Routes.HOME));
              },
              color: Colors.black,
              height: 55.h,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 34.sp,
                    );
                  } else {
                    return ReusableText1(
                      'Log In',
                      color: Colors.white,
                      size: 21.sp,
                      weight: FontWeight.bold,
                    );
                  }
                }),
              ),
            ),
            Gap(120.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontFamily: 'ferdoka',
                ),
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () => context.push(Routes.REGISTER),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
