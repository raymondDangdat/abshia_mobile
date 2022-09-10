import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';


class AppMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  const AppMenuItem({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppSize.s55.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s10
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: ColorManager.dummyUserCardColor,
          borderRadius: BorderRadius.circular(AppSize.s10.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: AppSize.s16.w,),
            Expanded(child: CustomTextWithLineHeight(
              isCenterAligned: false,
              text: title, fontSize: FontSize.s12, textColor: ColorManager.blackTextColor,),),
            SvgPicture.asset(AppImages.forwardArrow),
          ],
        )
    );
  }
}
