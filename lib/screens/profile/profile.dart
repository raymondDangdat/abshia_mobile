import 'package:abshia/models/dummy_user_model.dart';
import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/image_manager.dart';
import '../../resources/value_manager.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
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

            SizedBox(height: AppSize.s25.h,),
            Row(
              children: [
                SizedBox(
                  height: AppSize.s43.h,
                  child: CustomTextWithLineHeight(text: AppStrings.offlineReg, textColor: ColorManager.primaryColor, fontSize: FontSize.s26, fontWeight: FontWeightManager.bold, lineHeight: 1.2,),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: dummyUsers.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    final user = dummyUsers[index];
                    return Padding(padding: EdgeInsets.only(
                        bottom: AppSize.s6.h
                    ),
                      child: InkWell(
                        child: Container(
                          height: AppSize.s72.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12.r),
                              color: ColorManager.dummyUserCardColor
                          ),
                          alignment: Alignment.center,
                          child: ListTile(
                            leading: Container(
                              width: AppSize.s50.h,
                              height: AppSize.s50.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(user.avatar), fit: BoxFit.cover)
                              ),
                            ),

                            title: CustomText(text: user.fullName, textColor: ColorManager.dummyUserTextColor, fontWeight: FontWeightManager.semiBold, fontSize: FontSize.s16,),
                            subtitle: CustomText(text: user.regDate,  fontWeight: FontWeightManager.regular, fontSize: FontSize.s12,),

                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
