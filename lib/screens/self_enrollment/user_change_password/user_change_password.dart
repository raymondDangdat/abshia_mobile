import 'package:abshia/constants/validation.dart';
import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/image_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/resources/value_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:abshia/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../providers/authentication_provider.dart';


class UserChangePasswordScreen extends StatefulWidget {
  const UserChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UserChangePasswordScreen> createState() => _UserChangePasswordScreenState();
}

class _UserChangePasswordScreenState extends State<UserChangePasswordScreen> {
  final oldPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final newPasswordEditingController = TextEditingController();
  bool obSecureText = true;
  bool obSecureNewPassword = true;
  bool obSecureConfirmPassword = true;
  bool rememberMe = false;
  String newPassword = "-";
  String confirmPassword = "+";
  @override
  void initState() {
    oldPasswordEditingController.text = "smart2020";
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

                SizedBox(height: AppSize.s42.h,),
                SizedBox(child: CustomTextWithLineHeight(text: AppStrings.changePassword, fontSize: FontSize.s36, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor, isCenterAligned: false,),),
                SizedBox(height: AppSize.s36.h,),
                TextFormField(
                  controller: oldPasswordEditingController,
                  enabled: false,
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
                    // label: requiredField(AppStrings.oldPasswordLabel),
                    hintText: AppStrings.oldPasswordHint,
                    labelText: AppStrings.oldPasswordLabel,
                  ),
                ),

                SizedBox(height: AppSize.s22.h,),

                TextFormField(
                  controller: newPasswordEditingController,
                  autofocus: false,
                  maxLines: 1,
                  obscureText:  obSecureNewPassword,
                  obscuringCharacter: AppStrings.obscureCharacter,
                  onChanged: (value){
                    setState(() {
                      newPassword = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          setState(() {
                            obSecureNewPassword = !obSecureNewPassword;
                          });
                        },
                        child: Icon(obSecureNewPassword ? Icons.visibility_off : Icons.visibility)),
                    // filled: true,
                    // fillColor: ColorManager.textFilledColor,
                    label: requiredHint(AppStrings.newPasswordLabel),
                    hintText: AppStrings.newPasswordHint,
                    // labelText: AppStrings.newPasswordLabel,
                  ),
                ),

                SizedBox(height: AppSize.s22.h,),

                TextFormField(
                  controller: confirmPasswordEditingController,
                  autofocus: false,
                  maxLines: 1,
                  obscureText:  obSecureConfirmPassword,
                  obscuringCharacter: AppStrings.obscureCharacter,
                  onChanged: (value){
                    setState(() {
                      confirmPassword  = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (){
                          setState(() {
                            obSecureConfirmPassword = !obSecureConfirmPassword;
                          });
                        },
                        child: Icon(obSecureConfirmPassword ? Icons.visibility_off : Icons.visibility)),
                    // filled: true,
                    // fillColor: ColorManager.textFilledColor,
                    label: requiredHint(AppStrings.confirmPasswordLabel),
                    hintText: AppStrings.confirmPasswordHint,
                    // labelText: AppStrings.confirmPasswordLabel,
                  ),
                ),

                SizedBox(height: AppSize.s17.h,),
                Row(
                  children: [
                    SvgPicture.asset(contains8Characters(newPassword) ? AppImages.greenCheck : AppImages.redRequirement),
                    SizedBox(width: AppSize.s10.w,),
                    CustomTextWithLineHeight(text: AppStrings.minimumOf8, fontSize: FontSize.s12, textColor: contains8Characters(newPassword) ? ColorManager.greenColor : ColorManager.redColor,),
                  ],
                ),

                SizedBox(height: AppSize.s6.h,),

                Row(
                  children: [
                    SvgPicture.asset(containsOneAlphabet(newPassword.toLowerCase()) ? AppImages.greenCheck : AppImages.redRequirement),
                    SizedBox(width: AppSize.s10.w,),
                    CustomTextWithLineHeight(text: AppStrings.atLeast1Alpha, fontSize: FontSize.s12, textColor: containsOneAlphabet(newPassword.toLowerCase()) ? ColorManager.greenColor : ColorManager.redColor,),
                  ],
                ),

                SizedBox(height: AppSize.s6.h,),

                Row(
                  children: [
                    SvgPicture.asset(containsOneNumber(newPassword) ? AppImages.greenCheck : AppImages.redRequirement),
                    SizedBox(width: AppSize.s10.w,),
                    CustomTextWithLineHeight(text: AppStrings.atLeast1No, fontSize: FontSize.s12, textColor: containsOneNumber(newPassword) ? ColorManager.greenColor : ColorManager.redColor,),
                  ],
                ),
                SizedBox(height: AppSize.s62.h,),

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
                        if(newPassword == confirmPassword && containsOneNumber(newPassword) && containsOneAlphabet(newPassword.toLowerCase()) && contains8Characters(newPassword)){
                          auth.changePassword(oldPassword: "password", password: newPassword, password_confirmation: confirmPassword, context: context, isAgent: false, token: auth.enrolleeUser.token!);
                        }else{

                        }

                      }, AppStrings.resetPassword,
                          newPassword == confirmPassword && containsOneNumber(newPassword) && containsOneAlphabet(newPassword.toLowerCase()) && contains8Characters(newPassword) ? ColorManager.primaryColor : ColorManager.disabledButtonColor,
                          newPassword == confirmPassword && containsOneNumber(newPassword) && containsOneAlphabet(newPassword.toLowerCase()) && contains8Characters(newPassword) ? ColorManager.whiteColor : ColorManager.disabledButtonTextColor);
                    }
                ),
              ],
            ),
          )),
    );
  }
}
