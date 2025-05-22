import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note/app/modules/auth/controllers/auth_controller.dart';
import 'package:note/app/routes/app_pages.dart';

import '../../../widgets/reusable_text1.dart';
import '../widgets/custom_input_field.dart';

class SignUpView extends GetView<AuthController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(100.h),
            Image.asset('assets/images/notes.png', width: 65.h, height: 65.h),
            Gap(25.h),
            ReusableText1('Welcome', size: 25, weight: FontWeight.w600),
            Gap(70.h),

            CustomInputField(
              controller: controller.name,
              keyboard: TextInputType.name,
              hintText: 'Enter your name',
              prefixIcon: CupertinoIcons.signature,
            ),
            Gap(40.h),

            CustomInputField(
              controller: controller.emailR,
              keyboard: TextInputType.emailAddress,
              hintText: 'Enter your email',
              prefixIcon: Icons.email_rounded,
            ),
            Gap(40.h),

            Obx(
              () => CustomInputField(
                controller: controller.passwordR,
                hintText: 'Enter your password',
                prefixIcon: Icons.password,
                obscureText: controller.registerObscureText.value,
                hasToggleVisibility: true,
                onSuffixTap: () => controller.registerObscureText.toggle(),
                suffixVisibleIcon: Icons.visibility_rounded,
                suffixHiddenIcon: Icons.visibility_off_rounded,
              ),
            ),

            Gap(50.h),
            MaterialButton(
              onPressed: () {
                controller.register(onSuccess: () => context.go(Routes.LOGIN));
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
                      'Register',
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
                text: "Already have an account? ",
                children: [
                  TextSpan(
                    text: 'Log In',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    recognizer:
                        TapGestureRecognizer()..onTap = () => context.pop(),
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
