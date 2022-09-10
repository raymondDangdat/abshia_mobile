import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../providers/authentication_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reusable_widget.dart';

class SignUpScreenUser extends StatefulWidget {
  const SignUpScreenUser({Key? key}) : super(key: key);
  @override
  State<SignUpScreenUser> createState() => _SignUpScreenUserState();
}
class _SignUpScreenUserState extends State<SignUpScreenUser> {
  final emailEditingController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool obSecureText = true;
  bool rememberMe = false;
  bool acceptTermsAndCondition = false;
  @override
  void initState() {
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
                  child: CustomTextWithLineHeight(text: AppStrings.areYouNewHere, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),),

                SizedBox(height: AppSize.s90.h,),
                TextFormField(
                  controller: surnameController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  obscureText:  false,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.firstNameHint,
                    labelText: AppStrings.firstNameLabel,
                  ),
                ),
                SizedBox(height: AppSize.s14.h,),
                TextFormField(
                  controller: emailEditingController,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  obscureText:  false,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.hintEmailAddress,
                    labelText: AppStrings.hintEmailAddress,
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
                    hintText: AppStrings.password,
                    labelText: AppStrings.rPassword,
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
                SizedBox(height: AppSize.s10.h,),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                      acceptTermsAndCondition = !acceptTermsAndCondition;
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(acceptTermsAndCondition ? AppImages.checked : AppImages.unchecked),
                      SizedBox(width: AppSize.s10.w,),
                      CustomText(text: AppStrings.acceptTermsAndConditions),
                    ],
                  ),
                ),


                SizedBox(height: AppSize.s76.h,),
                Consumer<AuthenticationProvider>(
                    builder: (ctx, auth, child) {
                    return customElevatedButton(context, (){
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (auth.resMessage != '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: auth.resMessage
                            ),
                          );

                          ///Clear the response message to avoid duplicate
                          auth.clear();
                        }
                      });
                      if(emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty || !rememberMe || !acceptTermsAndCondition){
                      //Do nothing
                      }else{
                        auth.userSignup(email: emailEditingController.text.trim(), password: passwordEditingController.text.trim(), context: context, surname: surnameController.text.trim());
                      }

                    }, AppStrings.createAccount,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty || !rememberMe || !acceptTermsAndCondition ? ColorManager.disabledButtonColor : ColorManager.primaryColor,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty || !rememberMe || !acceptTermsAndCondition ? ColorManager.disabledButtonTextColor : ColorManager.whiteColor);
                  }
                ),
                SizedBox(height: AppSize.s40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.alreadyHaveAnAccount,),
                    SizedBox(width: AppSize.s5.w,),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.userLogin);
                        },
                        child: CustomTextWithLineHeight(text: AppStrings.signInHere, textColor: ColorManager.primaryColor,)),
                  ],
                ),

              ],
            ),
          )),
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

            Container(height: AppSize.s85.h,
              width: AppSize.s364.w,
              child: Column(
                children: [
                  CustomTextWithLineHeight(text: AppStrings.yourAccountHasBeenCreated, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                ],
              ),
            ),
            SizedBox(height: AppSize.s27.h,),

            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, Routes.optionScreen, (route) => false);
            }, AppStrings.closeApp, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),

            SizedBox(
              height: AppSize.s12.h,
            ),

            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.userLogin);
            }, AppStrings.login, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }
}
