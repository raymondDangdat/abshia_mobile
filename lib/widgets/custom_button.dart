import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/font_manager.dart';
import '../resources/value_manager.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Color textColor;
  final Color bgColor;
  final bool status;
  final Color borderColor;
  final FontWeight fontWeight;
  const CustomButton(
      {Key? key,
        required this.onTap,
        required this.text,
        this.fontSize = FontSize.s14,
        this.textColor = Colors.white,
        this.fontWeight = FontWeightManager.regular,
        this.width = 120,
        this.height = 40,
        this.borderColor = const Color.fromRGBO(0, 124, 255, 1),
        this.status = false,
        required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: status ? null : onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSize.s5.r),
            border: Border.all(
                color: borderColor
            )
        ),
        alignment: Alignment.center,
        child: CustomText(text: status ? "Loading..." : text, fontWeight: fontWeight, textColor: textColor, fontSize: fontSize,),
      ),
    );
  }
}