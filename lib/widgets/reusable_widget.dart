import 'package:abshia/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/value_manager.dart';
import 'custom_text.dart';

Widget elevatedButtonBorder(
    BuildContext context, VoidCallback onTap, String title) {
  return SizedBox(
    height: AppSize.s48.h,
    width: AppSize.s328.w,
    child: ElevatedButton(
      onPressed: onTap,
      child: Text(
        title,
        style: getCustomTextStyle(
            fontSize: FontSize.s14,
            textColor: ColorManager.primaryColor,
            fontWeight: FontWeightManager.medium),
      ),
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all<Color>(ColorManager.disabledButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s4.r))),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(ColorManager.whiteColor),
        side: MaterialStateProperty.all(
            BorderSide(width: AppSize.s1, color: ColorManager.primaryColor)),
        // padding: MaterialStateProperty.all(
        //     EdgeInsets.symmetric(horizontal: 50, vertical: 0)),
      ),
    ),
  );
}

Widget customElevatedButton(BuildContext context, VoidCallback onTap,
    String title, Color backgroundColor, Color textColor,
    {Color borderColor = Colors.transparent,
    FontWeight fontWeight = FontWeightManager.regular}) {
  return SizedBox(
    height: AppSize.s48.h,
    width: AppSize.s328.w,
    child: ElevatedButton(
      onPressed: onTap,
      child: CustomTextWithLineHeight(text: title, fontSize: FontSize.s16, textColor: textColor, fontWeight: fontWeight,),
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all<Color>(ColorManager.disabledButtonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s4.r))),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        side: MaterialStateProperty.all(
            BorderSide(width: AppSize.s1, color: borderColor)),
      ),
    ),
  );
}

Widget backButton(BuildContext context, String iconUrl) {
  return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SvgPicture.asset(iconUrl));
}

Widget keyButton(BuildContext context, String key) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s50.r)),
    child: Container(
      height: AppSize.s64.h,
      width: AppSize.s64.w,
      decoration: BoxDecoration(
        color: ColorManager.inputBorderColor,
        borderRadius: BorderRadius.circular(AppSize.s50.r),
      ),
      alignment: Alignment.center,
      child: Text(key,
          style: getCustomTextStyle(
              fontSize: FontSize.s24.sp,
              textColor: ColorManager.lightTextColor,
              fontWeight: FontWeight.w700)),
    ),
  );
}

Widget emptyButton() {
  return SizedBox(
    height: AppSize.s64.h,
    width: AppSize.s64.w,
  );
}

// Widget backSpaceButton(BuildContext context) {
//   return Container(
//     height: AppSize.s64,
//     width: AppSize.s64,
//     decoration: BoxDecoration(
//       color: ColorManager.inputBorderColor,
//       borderRadius: BorderRadius.circular(AppSize.s100),
//     ),
//     alignment: Alignment.center,
//     child: SvgPicture.asset(AppImages),
//   );
// }

Widget sideBarMenu(BuildContext context, VoidCallback onTap, String iconName,
    String menuName) {
  return InkWell(
    onTap: onTap,
    splashColor: ColorManager.whiteColor,
    child: Padding(
      padding: EdgeInsets.only(
        top: AppSize.s16.h,
        left: AppSize.s16.w,
      ),
      child: Row(
        children: [
          Container(
            height: AppSize.s24.h,
            width: AppSize.s24.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s4.r),
                color: ColorManager.backButtonColor),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s5.w, vertical: AppSize.s5.h),
              child: SvgPicture.asset(iconName),
            ),
          ),
          SizedBox(
            width: AppSize.s8.w,
          ),
          Text(
            menuName,
            style: getCustomTextStyle(
                fontSize: FontSize.s14.sp,
                textColor: ColorManager.primaryColor,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}


class RequiredLabel extends StatelessWidget {
  final String title;
  const RequiredLabel({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWithLineHeight(text: title),
        CustomTextWithLineHeight(text: AppStrings.obscureCharacter, textColor: ColorManager.redColor,),
      ],
    );;
  }
}

class HintText extends StatelessWidget {
  final String title;
  const HintText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWithLineHeight(text: title, textColor: Color.fromRGBO(183, 198, 212, 1),),
      ],
    );;
  }
}


Widget requiredHint(String title) {
  return Row(
    children: [
      CustomText(text: title,textColor: Color.fromRGBO(183, 198, 212, 1)),
      CustomText(text: AppStrings.obscureCharacter, textColor: ColorManager.redColor,),
    ],
  );
}

class EnrolleeDetailItem extends StatelessWidget {
  final String title;
  final String value;
  const EnrolleeDetailItem(this.title, this.value, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomTextWithLineHeight(text: title, fontSize: FontSize.s12,),
          ],
        ),

        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: CustomTextNoOverFlow(
                  text: value, fontSize: FontSize.s16, textColor: ColorManager.blackTextColor,)),
          ],
        ),

        SizedBox(height: AppSize.s12.h,)
      ],
    );;
  }
}


// Widget enrolleeDetailItem(String title, String value){
//   return Column(
//     children: [
//       Row(
//         children: [
//           CustomTextWithLineHeight(text: title, fontSize: FontSize.s12,),
//         ],
//       ),
//
//       Row(
//         children: [
//           SizedBox(
//               height: AppSize.s24.h,
//
//               child: CustomTextWithLineHeight(text: value, fontSize: FontSize.s16, textColor: ColorManager.blackTextColor,)),
//         ],
//       ),
//
//       SizedBox(height: AppSize.s12.h,)
//     ],
//   );
// }
