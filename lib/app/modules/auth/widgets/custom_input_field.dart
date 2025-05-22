import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final bool hasToggleVisibility;
  final VoidCallback? onSuffixTap;
  final IconData? suffixVisibleIcon;
  final IconData? suffixHiddenIcon;
  final TextInputType? keyboard;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.hasToggleVisibility = false,
    this.onSuffixTap,
    this.suffixVisibleIcon,
    this.suffixHiddenIcon,
    this.controller,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    final suffixIcon =
        hasToggleVisibility
            ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(
                obscureText ? suffixVisibleIcon : suffixHiddenIcon,
                size: 20.sp,
              ),
            )
            : null;

    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(prefixIcon, size: 20.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
