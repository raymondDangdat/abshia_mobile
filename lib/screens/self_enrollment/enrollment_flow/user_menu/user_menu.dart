import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/image_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../../resources/value_manager.dart';
import '../../../../widgets/menu_item.dart';


class UserMenuScreen extends StatelessWidget {
  const UserMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                    child: CustomTextWithLineHeight(text: AppStrings.menu, fontSize: FontSize.s36, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                ],
              ),),

            SizedBox(height: AppSize.s25.h,),

            SvgPicture.asset(AppImages.emptyProfileImage),
            SizedBox(height: AppSize.s6.h,),
            SizedBox(
                height: AppSize.s20.h,
                child: CustomTextWithLineHeight(text: AppStrings.uploadProfileImage, fontSize: FontSize.s12,)),

            SizedBox(height: AppSize.s20.h,),

            AppMenuItem(icon: AppImages.editProfile, title: AppStrings.editProfile),

            SizedBox(height: AppSize.s100.h,),
            AppMenuItem(icon: AppImages.infoIcon, title: AppStrings.aboutApp),
            SizedBox(height: AppSize.s26.h,),
            AppMenuItem(icon: AppImages.helpIcon, title: AppStrings.help),
            SizedBox(height: AppSize.s60.h,),
            InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, Routes.optionScreen, (route) => false);
                },
                child: AppMenuItem(icon: AppImages.logoutIcon, title: AppStrings.logout)),
          ],
        ),
      )),
    );
  }
}
