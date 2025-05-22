import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableText1 extends StatelessWidget {
  final String text;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final String? family;

  const ReusableText1(
    this.text, {
    super.key,
    this.weight,
    this.size,
    this.color,
    this.family,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: weight ?? FontWeight.normal,
        color: color ?? Colors.black,
        fontSize: size?.sp ?? 16.sp,
        fontFamily: family,
      ),
    );
  }
}
