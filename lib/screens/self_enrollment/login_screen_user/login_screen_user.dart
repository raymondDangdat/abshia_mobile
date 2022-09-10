import 'package:abshia/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../providers/authentication_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/share_prefs/local_user_data.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reusable_widget.dart';

class LoginScreenUser extends StatefulWidget {
  const LoginScreenUser({Key? key}) : super(key: key);
  @override
  State<LoginScreenUser> createState() => _LoginScreenUserState();
}
class _LoginScreenUserState extends State<LoginScreenUser> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool obSecureText = true;
  bool rememberMe = false;
  @override
  void initState() {

    rememberMe = LocalUserData.getEnrolleeRememberMeInfo();

    if(rememberMe){
      emailEditingController.text = LocalUserData.getEnrolleeEmail();
      passwordEditingController.text = LocalUserData.getEnrolleePassword();
    }
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
                  child: CustomTextWithLineHeight(text: AppStrings.welcomeBackSignIn, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),),

                SizedBox(height: AppSize.s90.h,),
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
                    // label: requiredField(AppStrings.emailAddressLabel),
                    hintText: AppStrings.hintEmailAddress,
                    labelText: AppStrings.emailAddressLabel,
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
                    // label: requiredField(AppStrings.rPassword),
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

                          LocalUserData.setRememberEnrolleePassword(rememberMe);
                        },
                        child: SvgPicture.asset(rememberMe ? AppImages.rememberMeChecked : AppImages.uncheck)),
                  ],
                ),
                SizedBox(height: AppSize.s76.h,),
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
                      if(emailEditingController.text.trim().isNotEmpty && passwordEditingController.text.trim().isNotEmpty){
                        if(rememberMe){
                          LocalUserData.setEnrolleeEmail(emailEditingController.text.trim());
                          LocalUserData.setEnrolleePassword(passwordEditingController.text.trim());
                        }else{
                          LocalUserData.setEnrolleeEmail("");
                          LocalUserData.setEnrolleePassword("");
                        }
                        auth.enrolleeLogin(
                            email: emailEditingController.text.trim(),
                            password: passwordEditingController.text,
                            context: context,
                            isAgent: false);
                      }

                    }, AppStrings.login,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty ? ColorManager.disabledButtonColor : ColorManager.primaryColor,
                        emailEditingController.text.trim().isEmpty || passwordEditingController.text.trim().isEmpty ? ColorManager.disabledButtonTextColor : ColorManager.whiteColor);
                  }
                ),
                SizedBox(height: AppSize.s40.h,),
                InkWell(
                  splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: CustomTextWithLineHeight(text: AppStrings.forgotPassword, textColor: ColorManager.primaryColor, fontSize: FontSize.s16)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.dontHaveAnAccount, fontSize: FontSize.s16),
                    SizedBox(width: AppSize.s5.w,),
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      onTap: (){
                        Navigator.pushNamed(context, Routes.signupUserScreen);
                      },
                        child: CustomTextWithLineHeight(text: AppStrings.signUpHere, textColor: ColorManager.primaryColor, fontSize: FontSize.s16,)),
                  ],
                ),

              ],
            ),
          )),
    );
  }
}
