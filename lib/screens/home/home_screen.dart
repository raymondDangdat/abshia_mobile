import 'package:abshia/models/enrollee_registration_info_model.dart';
import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/image_manager.dart';
import 'package:abshia/resources/routes_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import '../../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/offline_data_provider.dart';
import '../../resources/value_manager.dart';
import '../../widgets/abshia_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<OfflineEnrolleeData> offlineEnrollees = [];

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: PreferredSize(child: const AbshiaAppBar(), preferredSize: Size.fromHeight(AppSize.s50.h),),

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
        child: Column(
          children: [
            SizedBox(height: AppSize.s28.h,),
              SizedBox(
                height: 0,
              child: ValueListenableBuilder<Box<OfflineEnrolleeData>>(
                  valueListenable:
                  OfflineEnrollmentProvider.getOfflineEnrollee().listenable(),
                  builder: (context, Box<OfflineEnrolleeData> box, _) {
                    offlineEnrollees = box.values.toList().cast<OfflineEnrolleeData>();

                    return Container();
                  }),
            ),

            Container(
              height: AppSize.s124.h,
              child: ListView.builder(
                itemCount: enrolleeInfo.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                  final item = enrolleeInfo[index];
                return Container(
                    height: AppSize.s124.h,
                    width: AppSize.s336.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20.r),
                      image: DecorationImage(image: index == 0? AssetImage(AppImages.totalRegIcon) : AssetImage(AppImages.offlineRegIcon), fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: [
                        CustomTextWithLineHeight(text: index == 1? offlineEnrollees.length.toString() : auth.agentProfile.data!.details!.relationships!.enrolledUsers!.length.toString(), fontSize: FontSize.s48, fontWeight: FontWeightManager.bold, textColor: item.valueTextColor,),
                        // CustomTextWithLineHeight(text: index == 1? offlineEnrollees.length.toString() : auth.agentProfile.data!.details!.relationships!.enrolledUsers!.length.toString(), fontSize: FontSize.s48, fontWeight: FontWeightManager.bold, textColor: item.valueTextColor,),
                        CustomTextWithLineHeight(text: item.title, fontSize: FontSize.s16, textColor: item.titleColor,),
                      ],
                    )
                );
              }),
            ),

            SizedBox(height: AppSize.s22.h,),
            SizedBox(
              height: AppSize.s50.h,
              child: CustomTextWithLineHeight(text: AppStrings.selectFromTheReg, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold, isCenterAligned: false, lineHeight: 1.2, fontSize: FontSize.s21,),
            ),

            SizedBox(height: AppSize.s28.h,),

            Consumer<AuthenticationProvider>(
                builder: (ctx, auth, child) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(4.0),
                  childAspectRatio: 9.0 / 8.0,
                  children: auth.helper.data!.categories!.map(
                        (item) => InkWell(
                          onTap: ()async{

                            Navigator.pushNamed(context, Routes.personalDetails);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                SvgPicture.asset(AppImages.categoryIcon),
                                SizedBox(height: AppSize.s10.h,),
                                SizedBox(
                                  height: AppSize.s34.h,
                                  width: AppSize.s130.w,
                                  child: CustomTextWithLineHeight(text: item.title!, fontSize: FontSize.s12,),
                                )
                              ],
                            ),
                          ),
                        ),
                  )
                      .toList(),
                );
              }
            )
          ],
        ),
      )),
    );
  }
}
