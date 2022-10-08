import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/image_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../providers/authentication_provider.dart';
import '../../../../resources/value_manager.dart';


class UserPremium extends StatefulWidget {
  const UserPremium({Key? key}) : super(key: key);

  @override
  State<UserPremium> createState() => _UserPremiumState();
}

class _UserPremiumState extends State<UserPremium> {

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
        child: Column(
          children: [
            SizedBox(height: AppSize.s32.h,),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(height: AppSize.s43.h,
                    child: CustomTextWithLineHeight(text: AppStrings.premiumPlan, fontSize: FontSize.s36, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                ],
              ),),

            SizedBox(height: AppSize.s37.h,),

            Container(
              height: AppSize.s68.h,
              alignment: Alignment.centerLeft,
              color: Color.fromRGBO(239, 254, 244, 1),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.infoIconGreen),
                  SizedBox(width: AppSize.s8.w,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWithLineHeight(text: AppStrings.premiumPlan, textColor: Color.fromRGBO(4, 140, 91, 1),),
                      CustomTextWithLineHeight(text: AppStrings.planExpires, textColor: Color.fromRGBO(4, 140, 91, 1)),
                    ],
                  )
                ],
              )
            ),





            SizedBox(height: AppSize.s25.h,),
          ],
        ),
      )),
    );
  }

}
