import 'package:abshia/app/hive_impl/hive_models/offline_enrollee_data.dart';
import 'package:abshia/screens/select_plan/select_sub_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/offline_data_provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/reusable_widget.dart';
import 'offline_registration_completed.dart';


class EnrolleeDetails extends StatefulWidget {
  final OfflineEnrolleeData offlineEnrolleeData;
  final bool isOffline;
  const EnrolleeDetails({Key? key, required this.offlineEnrolleeData,
    this.isOffline = false,
  }) : super(key: key);

  @override
  State<EnrolleeDetails> createState() => _EnrolleeDetailsState();
}

class _EnrolleeDetailsState extends State<EnrolleeDetails> {
  late OfflineEnrolleeData _offlineEnrolleeData;
  late bool isOffline;

  @override
  void initState() {
    _offlineEnrolleeData = widget.offlineEnrolleeData;
    isOffline = widget.isOffline;

    setState(() {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppSize.s32.h,),

              Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
              child: Column(
                children: [
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
                          child: CustomTextWithLineHeight(text: AppStrings.enrolleeDetails, fontSize: FontSize.s21, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                      ],
                    ),),
                  SizedBox(height: AppSize.s17.h,),
                ],
              ),
              ),

              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
                child: Column(
                  children: [

                    EnrolleeDetailItem(AppStrings.enrolleeNumber, _offlineEnrolleeData.id.toString()),

                    EnrolleeDetailItem(AppStrings.name, "${_offlineEnrolleeData.firstName!} ${_offlineEnrolleeData.lastName!}"),

                    EnrolleeDetailItem(AppStrings.gender, _offlineEnrolleeData.gender!),

                    EnrolleeDetailItem(AppStrings.phoneNumberLabel, _offlineEnrolleeData.phoneNumber!),

                    EnrolleeDetailItem(AppStrings.emailAddressLabel, _offlineEnrolleeData.email!),

                    EnrolleeDetailItem(AppStrings.dateOfBirthLabel, _offlineEnrolleeData.dob!),

                    EnrolleeDetailItem(AppStrings.contactAddressLabel, _offlineEnrolleeData.contactAddress!),

                    EnrolleeDetailItem(AppStrings.bloodGroupLabel, _offlineEnrolleeData.bloodGroup!),

                    EnrolleeDetailItem(AppStrings.numberOfDependants, _offlineEnrolleeData.noOfDependants!),

                    EnrolleeDetailItem(AppStrings.maritalStatus, _offlineEnrolleeData.maritalStatus!),

                    EnrolleeDetailItem(AppStrings.hypertensive, _offlineEnrolleeData.hypertensive!),

                    EnrolleeDetailItem(AppStrings.sickleCell, _offlineEnrolleeData.sickleCell!),

                    EnrolleeDetailItem(AppStrings.cancer, _offlineEnrolleeData.cancer!),

                    EnrolleeDetailItem(AppStrings.kidneyIssue, _offlineEnrolleeData.kidneyIssue!),

                    EnrolleeDetailItem(AppStrings.category, _offlineEnrolleeData.category!),

                    EnrolleeDetailItem(AppStrings.healthCare, _offlineEnrolleeData.healthCare!),

                    EnrolleeDetailItem(AppStrings.genotype, _offlineEnrolleeData.genotype!),

                    EnrolleeDetailItem(AppStrings.existingMedicalCondition, _offlineEnrolleeData.existingMedicalCondition!),

                    EnrolleeDetailItem(AppStrings.nokName, _offlineEnrolleeData.nokName!),

                    EnrolleeDetailItem(AppStrings.nokPhoneNumber, _offlineEnrolleeData.nokPhoneNumber!),

                    EnrolleeDetailItem(AppStrings.nokRelationship, _offlineEnrolleeData.nokRelationship!),

                    EnrolleeDetailItem(AppStrings.nokAddress, _offlineEnrolleeData.nokAddress!),
                  ],
                ),
              )),

               !isOffline?  Consumer<OfflineEnrollmentProvider>(
                  builder: (ctx, offlineProvider, child) {
                  return customElevatedButton(context, (){
                    offlineProvider.addOfflineEnrollee(_offlineEnrolleeData);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OfflineRegistrationCompleted()));
                  }, AppStrings.saveOffline,
                    ColorManager.disabledButtonColor,
                    ColorManager.disabledButtonTextColor,);
                }
              ) : Container(),

              SizedBox(height: AppSize.s14.h,),
              customElevatedButton(context, (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectSubPlan(offlineEnrolleeData: _offlineEnrolleeData, isfromOffline: isOffline,)));
              }, AppStrings.submit,
                  ColorManager.primaryColor,
                  ColorManager.whiteColor,),
            ],
          )),
    );
  }
}
