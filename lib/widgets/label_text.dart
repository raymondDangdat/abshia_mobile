import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/value_manager.dart';
import 'custom_text.dart';

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s19.h,
        child: CustomText(text: text, fontSize: FontSize.s14, textColor: ColorManager.lightTextColor, fontWeight: FontWeightManager.regular,));
  }
}
