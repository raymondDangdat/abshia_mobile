import 'dart:async';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';

class OptionsScreenView extends StatefulWidget {
  const OptionsScreenView({Key? key}) : super(key: key);

  @override
  _OptionsScreenViewState createState() => _OptionsScreenViewState();
}

class _OptionsScreenViewState extends State<OptionsScreenView> {
  Timer? _timer;

  _startDelay(){
    _timer = Timer(const Duration(seconds: 4000), _goNext);
  }


  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.signInView);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.optionScreenBg), fit: BoxFit.cover)
      ),
      child: Container(
        color: ColorManager.overlayColor,
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s99.h,
            ),
            Container(
              height: AppSize.s144.h,
              width: AppSize.s144.h,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.abshia))
              ),
            ),
            SizedBox(height: AppSize.s21.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
              child: SizedBox(
                // height: AppSize.s96.h,
                child: CustomTextWithLineHeight(text: AppStrings.weImprove,textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.bold, lineHeight: 1.2, fontSize: FontSize.s21,),
              ),
            ),

            SizedBox(height: AppSize.s80.h,),

            SizedBox(height: AppSize.s68.h,
            child: CustomTextWithLineHeight(text: AppStrings.continueAs, textColor: ColorManager.whiteColor, fontSize: AppSize.s48, lineHeight: 1, fontWeight: FontWeightManager.bold, ),),

            SizedBox(height: AppSize.s21.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.signInView);
                    },
                    child: Container(
                      height: AppSize.s85.h,
                      width: AppSize.s85.h,
                      decoration: BoxDecoration(
                        color: ColorManager.agentContainerColor,
                        borderRadius: BorderRadius.circular(AppSize.s20.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset(AppImages.agentIcon),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  SizedBox(height: AppSize.s24.h,
                    child: CustomTextWithLineHeight(text: AppStrings.agent, textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16, lineHeight: 1.5,),)
                ],
              ),

                SizedBox(width: AppSize.s87.w,),

                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Routes.userLogin);
                      },
                      child: Container(
                        height: AppSize.s85.h,
                        width: AppSize.s85.h,
                        decoration: BoxDecoration(
                          color: ColorManager.userContainerColor,
                          borderRadius: BorderRadius.circular(AppSize.s20.r),
                        ),
                        child: Center(child: SvgPicture.asset(AppImages.userIcon)),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10.h,
                    ),
                    SizedBox(height: AppSize.s24.h,
                    child: CustomTextWithLineHeight(text: AppStrings.user, textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16, lineHeight: 1.5,),)
                  ],
                ),
            ],)
          ],
        ),),);
  }
}
