import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/image_manager.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/resources/value_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:abshia/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
            child: Column(
              children: [
                SizedBox(height: AppSize.s32.h,),
                SizedBox(
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.backButton)),
                    ],
                  ),),

                SizedBox(height: AppSize.s43.h,),
                SizedBox(child: CustomTextWithLineHeight(text: AppStrings.forgotPassword, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),),

                Container(
                  height: AppSize.s52.h,
                  alignment: Alignment.center,
                  child: CustomTextWithLineHeight(text: AppStrings.typeInTheEmailLinked, fontSize: FontSize.s14, lineHeight: 1.5, isCenterAligned: false,),),

                SizedBox(height: AppSize.s86.h,),



                TextFormField(
                  controller: emailEditingController,
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  obscuringCharacter: AppStrings.obscureCharacter,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: ColorManager.textFilledColor,
                    hintText: AppStrings.hintEmailAddress,
                    labelText: AppStrings.emailAddressLabel,
                  ),
                ),

                SizedBox(height: AppSize.s308.h,),

                customElevatedButton(context, (){
                  if(emailEditingController.text.isNotEmpty){
                    showLoginSuccess(context);
                  }else{

                  }

                }, AppStrings.resetPassword,
                    emailEditingController.text.trim().isNotEmpty ? ColorManager.primaryColor : ColorManager.disabledButtonColor,
                    emailEditingController.text.trim().isNotEmpty ? ColorManager.whiteColor : ColorManager.disabledButtonTextColor),
              ],
            ),
          )),
    );
  }

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s25.r),
        height: AppSize.s397.h,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s30.r),
              topRight: Radius.circular(AppSize.s30.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: AppSize.s54.h,
            ),
            SvgPicture.asset(AppImages.loginErrorIcon),
            SizedBox(
              height: AppSize.s32.h,
            ),

            SizedBox(height: AppSize.s30.h,
              child: CustomTextWithLineHeight(text: AppStrings.agentRecordNotFound, fontSize: FontSize.s16, lineHeight: 1.5,),
            ),
            SizedBox(height: AppSize.s50.h,),

            customElevatedButton(context, () {
              Navigator.pop(context);
            }, AppStrings.closeApp, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),

            SizedBox(
              height: AppSize.s12.h,
            ),

            customElevatedButton(context, () {
              Navigator.pop(context);
            }, AppStrings.tryAgain, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }


  void showLoginSuccess(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s25.r),
        height: AppSize.s397.h,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s30.r),
              topRight: Radius.circular(AppSize.s30.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: AppSize.s30.h,
            ),
            SvgPicture.asset(AppImages.loginSuccessIcon),
            SizedBox(
              height: AppSize.s35.h,
            ),

            Container(
              height: AppSize.s62.h,
              child:
                  CustomTextWithLineHeight(text: AppStrings.aLinkToResetYourPassword, fontSize: FontSize.s14, lineHeight: 1.5, isCenterAligned: true,),
            ),
            SizedBox(height: AppSize.s40.h,),

            customElevatedButton(context, () {
              Navigator.pop(context);
            }, AppStrings.skip, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),

            SizedBox(
              height: AppSize.s12.h,
            ),

            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, Routes.signInView, (route) => false);
            }, AppStrings.tryLoginAgain, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }

}
