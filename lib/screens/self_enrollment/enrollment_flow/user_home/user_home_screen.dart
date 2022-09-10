import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/image_manager.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/abshia_user_appbar.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/value_manager.dart';


class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: PreferredSize(child: const AbshiaUserAppBar(), preferredSize: Size.fromHeight(AppSize.s50.h),),

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
        child: Column(
          children: [
            SizedBox(height: AppSize.s28.h,),

            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s30.w,
                  vertical: AppSize.s18.h,
                ),
                // height: AppSize.s138.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(AppSize.s20.r),
                  image: DecorationImage(image: AssetImage(AppImages.totalRegIcon), fit: BoxFit.contain),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s20.h,
                        child: Row(
                          children: [
                            CustomTextWithLineHeight(text: AppStrings.currentPlan, fontSize: FontSize.s12, fontWeight: FontWeightManager.bold, textColor: ColorManager.faintTextColor),
                          ],
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: AppSize.s208.w,
                            child: CustomTextWithLineHeight(
                              isCenterAligned: false,
                              text: AppStrings.individualHealth, fontSize: FontSize.s16, textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.bold,)),
                      ],
                    ),

                    SizedBox(height: AppSize.s9.h,),
                    SizedBox(
                      height: AppSize.s20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextWithLineHeight(
                              isCenterAligned: false,
                              text: AppStrings.premium, fontSize: FontSize.s12, textColor: ColorManager.faintWhite, fontWeight: FontWeightManager.regular,),
                          ),

                          Expanded(
                            child: CustomTextWithLineHeight(
                              isCenterAligned: false,
                              text: AppStrings.status, fontSize: FontSize.s12, textColor: ColorManager.faintWhite, fontWeight: FontWeightManager.regular,),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: AppSize.s19.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextWithLineHeight(
                              isCenterAligned: false,
                              text: AppStrings.oneYear, fontSize: FontSize.s12, textColor: ColorManager.faintWhite, fontWeight: FontWeightManager.regular,),
                          ),

                          Expanded(
                            child: CustomTextWithLineHeight(
                              isCenterAligned: false,
                              text: AppStrings.active, fontSize: FontSize.s12, textColor: ColorManager.lightGreen, fontWeight: FontWeightManager.regular,),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            SizedBox(height: AppSize.s60.h,),

            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.bookAppointment);
              },
              child: Container(
                height: AppSize.s81.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 246, 252, 1),
                  borderRadius: BorderRadius.circular(AppSize.s12.r),
                ),
                alignment: Alignment.center,
                child: ListTile(
                  leading: SvgPicture.asset(AppImages.appointmentIcon),
                  title: SizedBox(
                    height: AppSize.s24.h,
                    child: CustomTextWithLineHeight(
                      isCenterAligned: false,
                        text: AppStrings.makeAppointment, fontSize: FontSize.s14, fontWeight: FontWeightManager.semiBold, textColor: ColorManager.blackTextColor),
                  ),

                  subtitle: SizedBox(
                    height: AppSize.s20.h,
                    child: CustomTextWithLineHeight(
                        isCenterAligned: false,
                        text: AppStrings.scheduleAppointment, fontSize: FontSize.s11, fontWeight: FontWeightManager.regular, textColor: ColorManager.faintTextColor),
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSize.s28.h,
            ),

            Container(
              height: AppSize.s39.h,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(239, 254, 244, 1),
                borderRadius: BorderRadius.circular(AppSize.s8.r)
              ),
              child: CustomTextWithLineHeight(
                  isCenterAligned: false,
                  text: AppStrings.editInformationSupplied, fontSize: FontSize.s14, fontWeight: FontWeightManager.regular, textColor:  Color.fromRGBO(4, 140, 91, 1)),
            )
          ],
        ),
      )),
    );
  }
}
