import 'package:abshia/providers/authentication_provider.dart';
import 'package:abshia/providers/helper_provider.dart';
import 'package:abshia/resources/color_manager.dart';
import 'package:abshia/resources/font_manager.dart';
import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/widgets/reusable_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../../models/premium_model.dart';
import '../../models/sub_plans.dart';
import '../../resources/image_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/custom_text.dart';


class EnrolleePlanSelection extends StatefulWidget {
  final OfflineEnrolleeData offlineEnrolleeData;
  const EnrolleePlanSelection({Key? key, required this.offlineEnrolleeData}) : super(key: key);

  @override
  State<EnrolleePlanSelection> createState() => _EnrolleePlanSelectionState();
}

class _EnrolleePlanSelectionState extends State<EnrolleePlanSelection> {
  String? selectedPlan;
  String? selectedPremium;

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthenticationProvider>(context, listen: true);
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

                      SizedBox(width: AppSize.s16.w,),

                      SizedBox(height: AppSize.s25.h,
                        child: CustomTextWithLineHeight(text: AppStrings.plan, fontSize: FontSize.s21, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                    ],
                  ),),

                SizedBox(height: AppSize.s25.h,),
                Row(
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.kindleSelect, fontSize: FontSize.s21, fontWeight: FontWeightManager.bold, textColor: ColorManager.blackTextColor,),
                  ],
                ),

                SizedBox(height: AppSize.s18,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: AppSize.s48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorManager.cardColor,
                              borderRadius: BorderRadius.circular(AppSize.s4.r),
                              border: Border.all(
                                  color: ColorManager.inputBorderColor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              focusColor: ColorManager.primaryColor,
                              isExpanded: true,
                              hint: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Expanded(
                                      child: requiredHint(AppStrings.planTypeLabel)),
                                ],
                              ),
                              items: subPlans
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                      value: item,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          CustomText(text: item),
                                        ],
                                      )))
                                  .toList(),
                              value: selectedPlan,
                              onChanged: (value) {

                                selectedPlan =
                                value as String;

                                setState(() {

                                });
                              },
                              icon: SvgPicture.asset(AppImages.dropdownIcon),
                              iconSize: 14,
                              buttonHeight: 50,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s6.r),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: ColorManager.whiteColor,
                              ),
                              itemHeight: 40,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s4.r),
                              ),
                              dropdownElevation: 8,
                              selectedItemHighlightColor:
                              ColorManager.backButtonColor,
                              scrollbarAlwaysShow: false,
                              offset: const Offset(0, 0),
                            ),
                          )
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSize.s12.h,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: AppSize.s48.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorManager.cardColor,
                              borderRadius: BorderRadius.circular(AppSize.s4.r),
                              border: Border.all(
                                  color: ColorManager.inputBorderColor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              focusColor: ColorManager.primaryColor,
                              isExpanded: true,
                              hint: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Expanded(
                                      child: requiredHint(AppStrings.premium)),
                                ],
                              ),
                              items: premiums
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                      value: item,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          CustomText(text: item),
                                        ],
                                      )))
                                  .toList(),
                              value: selectedPremium,
                              onChanged: (value) {

                                selectedPremium =
                                value as String;

                                setState(() {

                                });
                              },
                              icon: SvgPicture.asset(AppImages.dropdownIcon),
                              iconSize: 14,
                              buttonHeight: 50,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s6.r),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: ColorManager.whiteColor,
                              ),
                              itemHeight: 40,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s4.r),
                              ),
                              dropdownElevation: 8,
                              selectedItemHighlightColor:
                              ColorManager.backButtonColor,
                              scrollbarAlwaysShow: false,
                              offset: const Offset(0, 0),
                            ),
                          )
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSize.s90.h,),

                Row(
                  children: [
                    SizedBox(
                        height: AppSize.s24.h,
                        child: CustomTextWithLineHeight(text: AppStrings.totalAmount)),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(
                      //   height: AppSize.s48.h,
                      child: CustomTextWithLineHeight(text: "N100,000,000", textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s36,),
                    ),
                  ],
                ),

                SizedBox(
                  height: AppSize.s173.h,
                ),
                Consumer<HelperProvider>(
                    builder: (ctx, helper, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (helper.resMessage != '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: helper.resMessage
                              ,
                            ),
                          );

                          ///Clear the response message to avoid duplicate
                          helper.clear();
                        }
                      });
                      return customElevatedButton(context, ()async{
                        //
                        final enrolled =  await helper.updateEnrollmentDetail(context, widget.offlineEnrolleeData, auth.enrolleeUser.token!, "");

                        if(enrolled){
                          print("Enrolled!");
                          await auth.getAgentProfile(context);
                          Navigator.pushNamed(context, Routes.enrolleePaymentSuccessful);
                        }




                      }, AppStrings.proceedToPayment,
                        selectedPremium == null || selectedPlan == null? ColorManager.disabledButtonColor : ColorManager.primaryColor,
                        selectedPremium == null || selectedPlan == null? ColorManager.disabledButtonTextColor : ColorManager.whiteColor,);
                    }
                ),




              ],
            ),
          )),
    );
  }
}
