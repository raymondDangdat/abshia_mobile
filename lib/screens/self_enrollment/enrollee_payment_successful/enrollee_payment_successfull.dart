import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/image_manager.dart';
import '../../../resources/value_manager.dart';


class EnrolleePaymentSuccessful extends StatefulWidget {
  const EnrolleePaymentSuccessful({Key? key}) : super(key: key);

  @override
  State<EnrolleePaymentSuccessful> createState() => _EnrolleePaymentSuccessfulState();
}

class _EnrolleePaymentSuccessfulState extends State<EnrolleePaymentSuccessful> {


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
                            Navigator.pushNamedAndRemoveUntil(context, Routes.userNavScreen, (route) => false);
                          },
                          child: SvgPicture.asset(AppImages.backButton)),
                    ],
                  ),),

                SizedBox(height: AppSize.s208.h,),

                SvgPicture.asset(AppImages.offlineTransactionCompletedCircle),

                SizedBox(height: AppSize.s48.h,),
                Container(
                  width: AppSize.s364.w,
                  height: AppSize.s57.h,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
                  child: CustomTextWithLineHeight(text: AppStrings.paymentSuccessful, textColor: ColorManager.primaryColor, fontSize: FontSize.s16,),
                )

              ],
            ),
          )),
    );
  }
}
