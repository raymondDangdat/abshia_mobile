import 'package:abshia/providers/offline_data_provider.dart';
import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../../resources/image_manager.dart';
import '../../resources/value_manager.dart';
import '../user_enrollment_flow/enrollee_details.dart';
import 'package:timeago/timeago.dart' as timeago;


class OfflineRegistration extends StatefulWidget {
  const OfflineRegistration({Key? key}) : super(key: key);

  @override
  State<OfflineRegistration> createState() => _OfflineRegistrationState();
}

class _OfflineRegistrationState extends State<OfflineRegistration> {
  List<OfflineEnrolleeData> offlineEnrollees = [];
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
              child: ValueListenableBuilder<Box<OfflineEnrolleeData>>(
                  valueListenable:
                  OfflineEnrollmentProvider.getOfflineEnrollee().listenable(),
                  builder: (context, Box<OfflineEnrolleeData> box, _) {
                    offlineEnrollees = box.values.toList().cast<OfflineEnrolleeData>();

                    return buildContent(context, box, offlineEnrollees);
                  }),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildContent(
      BuildContext context, Box<OfflineEnrolleeData> box, List<OfflineEnrolleeData> offlineEnrolls) {
    if (offlineEnrolls.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: AppSize.s128.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "No Records", textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s18,)
          ],
        ),
      );
    } else {
      offlineEnrollees = box.values.toList().cast<OfflineEnrolleeData>();
      return ListView.builder(
          itemCount: offlineEnrollees.length,
          // reverse: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index){
            final user = offlineEnrollees[index];
            return Dismissible(
              key: Key(user.id!),
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  box.delete(user.id);
                });
              },
              child: Padding(padding: EdgeInsets.only(
                  bottom: AppSize.s6.h
              ),
                child: InkWell(
                  onTap: ()async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EnrolleeDetails(
                      offlineEnrolleeData: user, isOffline: true,)));
                  },
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
                            image: DecorationImage(image: AssetImage("assets/images/dummy_avatar.png"), fit: BoxFit.cover)
                        ),
                      ),

                      title: CustomText(text: "${user.firstName!} ${user.lastName?? ''}", textColor: ColorManager.dummyUserTextColor, fontWeight: FontWeightManager.semiBold, fontSize: FontSize.s16,),
                      subtitle: CustomText(text: user.dateRegistered == null ? "" : timeago.format(user.dateRegistered!), fontWeight: FontWeightManager.regular, fontSize: FontSize.s12,),
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}
