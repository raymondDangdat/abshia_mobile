import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/image_manager.dart';
import '../../resources/value_manager.dart';


class OfflineRegistrationCompleted extends StatefulWidget {
  const OfflineRegistrationCompleted({Key? key}) : super(key: key);

  @override
  State<OfflineRegistrationCompleted> createState() => _OfflineRegistrationCompletedState();
}

class _OfflineRegistrationCompletedState extends State<OfflineRegistrationCompleted> {


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
                            Navigator.pushNamedAndRemoveUntil(context, Routes.navScreen, (route) => false);
                          },
                          child: SvgPicture.asset(AppImages.backButton)),
                    ],
                  ),),
                
                SizedBox(height: AppSize.s250.h,),
                
                SvgPicture.asset(AppImages.offlineTransactionCompletedCircle),

                SizedBox(height: AppSize.s50.h,),
                Container(
                  width: AppSize.s364.w,
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
                  child: CustomTextWithLineHeight(text: AppStrings.enrolleeInfoHas, textColor: ColorManager.primaryColor, fontSize: FontSize.s16,),
                )

              ],
            ),
          )),
    );
  }
}
