import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'custom_text.dart';

class AbshiaAppBar extends StatefulWidget {
  const AbshiaAppBar({Key? key}) : super(key: key);

  @override
  State<AbshiaAppBar> createState() => _AbshiaAppBarState();
}

class _AbshiaAppBarState extends State<AbshiaAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(top: AppSize.s10.h, bottom: AppSize.s5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: AppSize.s10.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.s27.h,
                      child: CustomText(text: "👋 Hello!", textColor: ColorManager.boldTextColor,  fontSize: FontSize.s14,)
                        ),
                    SizedBox(height: AppSize.s20.h,
                      child: Consumer<AuthenticationProvider>(
                          builder: (ctx, auth, child) {
                          return CustomText(text: auth.userData.user!.details!.name!, textColor: ColorManager.blackTextColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s14,);
                        }
                      ),),


                  ],
                )

              ],
            ),


            Row(
              children: [
                Container(height: AppSize.s48.h,
                  width: AppSize.s48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s50.r),
                    image: DecorationImage(image: AssetImage(AppImages.profile))
                  ),
                ),

                SizedBox(width: AppSize.s10.w,),

              ],
            ),
          ],
        ),
      ),
    );


  }

}
