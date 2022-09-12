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
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../providers/authentication_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool obSecureText = true;
  bool rememberMe = false;

  @override
  void initState() {
    emailEditingController.text = "orutu1@gmail.com";
    passwordEditingController.text = "password";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
            child: Column(
              children: [
                SizedBox(height: AppSize.s92.h,),
                SizedBox(
                child: Row(
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.welcome, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),
                  ],
                ),),

                SizedBox(
                  child: Row(
                    children: [
                      CustomTextWithLineHeight(text: AppStrings.signInToContinue, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),
                    ],
                  ),),

                SizedBox(height: AppSize.s16.h,),

                CustomTextWithLineHeight(text: AppStrings.rememberToChange, isCenterAligned: false, textColor: ColorManager.blackTextColor, fontSize: FontSize.s16,),

                SizedBox(height: AppSize.s60.h,),
                TextFormField(
                  controller: emailEditingController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  obscureText:  false,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: ColorManager.textFilledColor,
                    label: requiredHint(AppStrings.emailAddressLabel),
                    hintText: AppStrings.hintEmailAddress,
                    // labelText: AppStrings.emailAddressLabel,
                  ),
                ),

                SizedBox(height: AppSize.s14.h,),
                TextFormField(
                  controller: passwordEditingController,
                  autofocus: false,
                  maxLines: 1,
                  obscureText:  obSecureText,
                  obscuringCharacter: AppStrings.obscureCharacter,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          obSecureText = !obSecureText;
                        });
                      },
                        child: Icon(obSecureText ? Icons.visibility_off : Icons.visibility)),
                    // filled: true,
                    // fillColor: ColorManager.textFilledColor,
                    label: requiredHint(AppStrings.rPassword),
                    hintText: AppStrings.password,
                    // labelText: AppStrings.rPassword,
                  ),
                ),

                SizedBox(height: AppSize.s8.h,),

                Row(
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                        child: SvgPicture.asset(rememberMe ? AppImages.rememberMeChecked : AppImages.uncheck)),
                  ],
                ),
                SizedBox(height: AppSize.s62.h,),
                //
                Consumer<AuthenticationProvider>(
                    builder: (ctx, auth, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: auth.resMessage
                              ,
                            ),
                          );

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                    return customElevatedButton(context, (){

                      if(emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty){
                      //  Do nothing
                      }else{
                        auth.loginAgent(
                            email: emailEditingController.text.trim(),
                            password: passwordEditingController.text,
                            context: context,
                        isAgent: true);
                        // if(passwordEditingController.text.trim() == "smart2020" && emailEditingController.text.trim() == "abshia@gmail.com"){
                        //   showLoginSuccess(context);
                        // }else{
                        //   show(context);
                        // }
                      }

                    }, AppStrings.signIn,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty ? ColorManager.disabledButtonColor : ColorManager.primaryColor,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty ? ColorManager.disabledButtonTextColor : ColorManager.whiteColor);
                  }
                ),

                SizedBox(height: AppSize.s40.h,),

                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.forgotPassword);
                  },
                    child: CustomTextWithLineHeight(text: AppStrings.forgotPassword, textColor: ColorManager.primaryColor,)),

                CustomTextWithLineHeight(text: AppStrings.contactTheAdmin,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.detailsAdmin,),
                    CustomTextWithLineHeight(text: AppStrings.adminEmail, textColor: ColorManager.primaryColor,),
                  ],
                ),



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

            Container(height: AppSize.s62.h,
              child: Column(
                children: [
                  CustomTextWithLineHeight(text: AppStrings.signInSuccessful, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                  CustomTextWithLineHeight(text: AppStrings.startChangingYour, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                ],
              ),
            ),
            SizedBox(height: AppSize.s40.h,),

            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, Routes.navScreen, (route) => false);
            }, AppStrings.skip, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),

            SizedBox(
              height: AppSize.s12.h,
            ),

            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.changePassword);
            }, AppStrings.conntinue, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }

}
