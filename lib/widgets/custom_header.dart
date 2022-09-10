import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';

class CustomHeader extends StatelessWidget {

  const CustomHeader(
      {Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppSize.s35.w,),
        SvgPicture.asset(AppImages.abshia),
        SizedBox(width: AppSize.s10.w,),
        // Text(AppStrings.kobocounter, style: getCustomTextStyle(fontSize: FontSize.s36.sp, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.extraBold),),
      ],
    );
  }
}