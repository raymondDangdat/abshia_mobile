import 'package:abshia/models/blood_group_model.dart';
import 'package:abshia/models/gender_model.dart';
import 'package:abshia/models/title_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../../../models/countries_model.dart';
import '../../../models/helper_model.dart';
import '../../../models/local_government_model.dart';
import '../../../providers/authentication_provider.dart';
import '../../../providers/helper_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reusable_widget.dart';
import 'enrolleement_details.dart';


class UserPersonalDetails extends StatefulWidget {
  const UserPersonalDetails({Key? key}) : super(key: key);

  @override
  State<UserPersonalDetails> createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {
  final emailEditingController = TextEditingController();
  final fullNameEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final dobEditingController = TextEditingController();
  final contactAddressEditingController = TextEditingController();

  String? selectedBloodGroup;
  String? selectedTitle;
  String? selectedCountry;

  int selectedGender = 0;

  DateTime selectedDate = DateTime.now();

  final middleNameController = TextEditingController();
  final noOfDependantController = TextEditingController();
  final nokNameController = TextEditingController();
  final nokPhoneNumberController = TextEditingController();
  final nokRelationshipController = TextEditingController();
  final nokAddressController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String? selectedHypertensiveStatus;
  String? selectedMaritalStatus;
  String? selectedSickleCellStatus;
  String? selectedCancerStatus;
  String? selectedKidneyStatus;
  Category? selectedCategory;
  String? selectedGenotype;
  Hospital? selectedHealthCare;
  String? selectedExistingMedicalConditionStatus;
  NgStateModel? selectedState;
  Lgas? selectedLga;



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final dob = "${selectedDate.year}-${selectedDate.month < 10 ? '0${selectedDate.month}' : selectedDate.month}-${selectedDate.day < 10 ? '0${selectedDate.day}' : selectedDate.day}";
        dobEditingController.text = dob;
      });
    }
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final auth = Provider.of<AuthenticationProvider>(context, listen: false);
      lastNameController.text = auth.enrolleeUser.user!.details!.surname?? "";
      emailEditingController.text = auth.enrolleeUser.user!.email ?? "";

    });
  }

  @override
  Widget build(BuildContext context) {
    var helperProvider = Provider.of<HelperProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppSize.s32.h,),
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.backButton)),

                      SizedBox(width: AppSize.s16.w,),

                      SizedBox(height: AppSize.s25.h,
                        child: CustomTextWithLineHeight(text: AppStrings.step1, fontSize: FontSize.s21, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                    ],
                  ),
                ),),

              SizedBox(height: AppSize.s25.h,),
              SizedBox(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
                child: Row(
                  children: [
                    CustomTextWithLineHeight(text: AppStrings.personalDetails, fontSize: FontSize.s21, lineHeight: 1.2, fontWeight: FontWeightManager.bold, textColor: ColorManager.blackTextColor, isCenterAligned: false,),
                  ],
                ),
              ),),

              SizedBox(height: AppSize.s18.h,),

              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
                child: Column(
                  children: [
                    SizedBox(height: AppSize.s18.h,),
                    RequiredLabel(title: AppStrings.titleLabel),
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
                                          child: HintText(title: AppStrings.titleLabel)),
                                    ],
                                  ),
                                  items: titles
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
                                  value: selectedTitle,
                                  onChanged: (value) {
                                    selectedTitle =
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
                    TextFormField(
                      controller: firstNameController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        hintText: AppStrings.firstNameHint,
                        labelText: AppStrings.firstNameLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: lastNameController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        hintText: AppStrings.surnameLabel,
                        labelText: AppStrings.surnameLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: middleNameController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        hintText: AppStrings.middleNameLabel,
                        labelText: AppStrings.middleNameLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    Row(
                      children: [
                        CustomTextWithLineHeight(text: AppStrings.gender),
                      ],
                    ),
                    SizedBox(height: AppSize.s24.h,
                      child: ListView.builder(
                          itemCount: genders.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            final gender = genders[index];
                            return Padding(
                              padding: EdgeInsets.only(right: AppSize.s15.w),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: (){
                                  setState(() {
                                    selectedGender = index;
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(selectedGender == index? AppImages.genderChecked : AppImages.genderUnchecked),
                                    SizedBox(width: AppSize.s7.w,),
                                    CustomTextWithLineHeight(text: gender)
                                  ],
                                ),
                              ),
                            );
                          }),),
                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: phoneNumberEditingController,
                      autofocus: false,
                      maxLines: 1,
                      maxLength: 11,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                      ],
                      keyboardType: TextInputType.phone,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        label: requiredHint(AppStrings.phoneNumberLabel),
                        hintText: AppStrings.phoneNumberHint,
                        // labelText: AppStrings.phoneNumberLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: emailEditingController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        label: requiredHint(AppStrings.emailAddressLabel),
                        hintText: AppStrings.hintEmailAddress,
                      ),
                    ),
                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: dobEditingController,
                      autofocus: false,
                      maxLines: 1,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9/]")),
                      ],
                      keyboardType: TextInputType.emailAddress,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        label: requiredHint(AppStrings.dateOfBirthLabel),
                        hintText: AppStrings.dateOfBirthHint,
                        // labelText: AppStrings.dateOfBirthLabel,
                        counterText: "",
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10.r),
                          child: InkWell(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: SvgPicture.asset(AppImages.calendarIcon)),
                        ),

                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),

                    RequiredLabel(title: AppStrings.state),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<AuthenticationProvider>(
                              builder: (ctx, auth, child) {
                                return Container(
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
                                                child: HintText(title: AppStrings.state)),
                                          ],
                                        ),
                                        items: auth.helper.data!.states!
                                            .map((item) =>
                                            DropdownMenuItem<NgStateModel>(
                                                value: item,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    CustomText(text: item.stateName!),
                                                  ],
                                                )))
                                            .toList(),
                                        value: selectedState,
                                        onChanged: (value) async{
                                          selectedState = value as NgStateModel;
                                          selectedLga = null;
                                          await helperProvider.getLgas(context, selectedState!.id!.toString());
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
                                );
                              }
                          ),
                        ),
                      ],
                    ),

                    if(selectedState != null && !helperProvider.isLoading)
                      SizedBox(height: AppSize.s12.h,),
                    if(selectedState != null && !helperProvider.isLoading)
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<AuthenticationProvider>(
                                builder: (ctx, auth, child) {
                                  return Container(
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
                                            children: [
                                              Expanded(
                                                  child: requiredHint(AppStrings.lga)),
                                            ],
                                          ),
                                          items: helperProvider.helper.data!.lgas!
                                              .map((item) =>
                                              DropdownMenuItem<Lgas>(
                                                  value: item,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      CustomText(text: item.lgaName!),
                                                    ],
                                                  )))
                                              .toList(),
                                          value: selectedLga,
                                          onChanged: (value) {

                                            selectedLga =
                                            value as Lgas;

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
                                  );
                                }
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: contactAddressEditingController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: ColorManager.textFilledColor,
                        label: requiredHint(AppStrings.contactAddressLabel),
                        hintText: AppStrings.contactAddressHint,
                        // labelText: AppStrings.contactAddressLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    RequiredLabel(title: AppStrings.bloodGroupLabel),
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
                                          child: HintText(title: AppStrings.bloodGroupLabel)),
                                    ],
                                  ),
                                  items: bloodGroups
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
                                  value: selectedBloodGroup,
                                  onChanged: (value) {

                                    selectedBloodGroup =
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

                    TextFormField(
                      controller: noOfDependantController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                      ],
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: ColorManager.textFilledColor,
                        label: requiredHint(AppStrings.numberOfDependants),
                        hintText: AppStrings.numberOfDependants,
                        // labelText: AppStrings.contactAddressLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    RequiredLabel(title: AppStrings.maritalStatus),
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
                                          child: HintText(title: AppStrings.maritalStatus)),
                                    ],
                                  ),
                                  items: maritalStatuses
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
                                  value: selectedMaritalStatus,
                                  onChanged: (value) {

                                    selectedMaritalStatus =
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
                    RequiredLabel(title: AppStrings.hypertensive),
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
                                          child: HintText(title: AppStrings.hypertensive)),
                                    ],
                                  ),
                                  items: yesOrNos
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
                                  value: selectedHypertensiveStatus,
                                  onChanged: (value) {

                                    selectedHypertensiveStatus =
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
                    RequiredLabel(title: AppStrings.sickleCell),
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
                                          child: HintText(title: AppStrings.sickleCell)),
                                    ],
                                  ),
                                  items: yesOrNos
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
                                  value: selectedSickleCellStatus,
                                  onChanged: (value) {

                                    selectedSickleCellStatus =
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
                    RequiredLabel(title: AppStrings.cancer),
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
                                          child: HintText(title: AppStrings.cancer)),
                                    ],
                                  ),
                                  items: yesOrNos
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
                                  value: selectedCancerStatus,
                                  onChanged: (value) {
                                    selectedCancerStatus =
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
                    RequiredLabel(title: AppStrings.kidneyIssue),
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
                                          child: HintText(title: AppStrings.kidneyIssue)),
                                    ],
                                  ),
                                  items: yesOrNos
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
                                  value: selectedKidneyStatus,
                                  onChanged: (value) {

                                    selectedKidneyStatus =
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
                    RequiredLabel(title: AppStrings.category),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<AuthenticationProvider>(
                              builder: (ctx, auth, child) {
                                return Container(
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
                                          children: [
                                            Expanded(
                                                child: HintText(title: AppStrings.category)),
                                          ],
                                        ),
                                        items: auth.helper.data!.categories!
                                            .map((item) =>
                                            DropdownMenuItem<Category>(
                                                value: item,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    CustomText(text: item.title!),
                                                  ],
                                                )))
                                            .toList(),
                                        value: selectedCategory,
                                        onChanged: (value) {
                                          selectedCategory =
                                          value as Category;
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
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s12.h,),
                    RequiredLabel(title: AppStrings.healthCare),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer<AuthenticationProvider>(
                              builder: (ctx, auth, child) {
                                return Container(
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
                                                child: HintText(title: AppStrings.healthCare)),
                                          ],
                                        ),
                                        items: auth.helper.data!.hospitals!
                                            .map((item) =>
                                            DropdownMenuItem<Hospital>(
                                                value: item,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    CustomText(text: item.name!),
                                                  ],
                                                )))
                                            .toList(),
                                        value: selectedHealthCare,
                                        onChanged: (value) {

                                          selectedHealthCare =
                                          value as Hospital;

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
                                );
                              }
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSize.s12.h,),

                    RequiredLabel(title: AppStrings.genotype),
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
                                          child: HintText(title: AppStrings.genotype,)),
                                    ],
                                  ),
                                  items: genotypes
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
                                  value: selectedGenotype,
                                  onChanged: (value) {

                                    selectedGenotype =
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
                    RequiredLabel(title: AppStrings.existingMedicalCondition),
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
                                          child: HintText(title: AppStrings.existingMedicalCondition)),
                                    ],
                                  ),
                                  items: yesOrNos
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
                                  value: selectedExistingMedicalConditionStatus,
                                  onChanged: (value) {

                                    selectedExistingMedicalConditionStatus =
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



                    SizedBox(height: AppSize.s22.h,),
                    Row(
                      children: [
                        SizedBox(
                            height: AppSize.s25.h,
                            child: CustomText(text: AppStrings.nextOfKinDetails, textColor: ColorManager.blackTextColor, fontSize: FontSize.s21, fontWeight: FontWeightManager.bold,)),
                      ],
                    ),

                    SizedBox(height: AppSize.s18.h,),
                    TextFormField(
                      controller: nokNameController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: ColorManager.textFilledColor,
                        label: requiredHint(AppStrings.nokName),
                        hintText: AppStrings.nokName,
                        // labelText: AppStrings.contactAddressLabel,
                      ),
                    ),

                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: nokPhoneNumberController,
                      autofocus: false,
                      maxLines: 1,
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      obscuringCharacter: AppStrings.obscureCharacter,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                      ],
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        label: requiredHint(AppStrings.nokPhoneNumber),
                        hintText: AppStrings.nokPhoneNumber,
                      ),
                    ),
                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: nokRelationshipController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        label: requiredHint(AppStrings.nokRelationship),
                        hintText: AppStrings.nokRelationship,
                        // labelText: AppStrings.contactAddressLabel,
                      ),
                    ),
                    SizedBox(height: AppSize.s12.h,),
                    TextFormField(
                      controller: nokAddressController,
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (value){
                        setState(() {
                        });
                      },
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: ColorManager.textFilledColor,
                        label: requiredHint(AppStrings.nokAddress),
                        hintText: AppStrings.nokAddress,
                        // labelText: AppStrings.contactAddressLabel,
                      ),
                    ),
                  ],
                ),
              )),



              SizedBox(height: AppSize.s14.h,),
              customElevatedButton(context, (){
                if(emailEditingController.text.trim().isNotEmpty && middleNameController.text.trim().isNotEmpty && phoneNumberEditingController.text.trim().isNotEmpty && contactAddressEditingController.text.trim().isNotEmpty && dobEditingController.text.trim().isNotEmpty && selectedState != null && contactAddressEditingController.text.trim().isNotEmpty && selectedBloodGroup != null && selectedMaritalStatus != null && selectedHypertensiveStatus != null && selectedSickleCellStatus != null && selectedSickleCellStatus != null && selectedCancerStatus != null && selectedKidneyStatus != null && selectedCategory != null && selectedHealthCare != null && selectedGenotype != null && selectedExistingMedicalConditionStatus != null && nokNameController.text.trim().isNotEmpty && nokPhoneNumberController.text.isNotEmpty && nokAddressController.text.isNotEmpty && nokRelationshipController.text.trim().isNotEmpty){
                  final offlineEnrollee = OfflineEnrolleeData(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    firstName: firstNameController.text,
                    gender: selectedGender == 0? "Male" : selectedGender == 1 ? "Female" : "Others",
                    phoneNumber: phoneNumberEditingController.text,
                    email: emailEditingController.text.trim(),
                    dob: dobEditingController.text.trim(),
                    contactAddress: contactAddressEditingController.text.trim(),
                    bloodGroup: selectedBloodGroup,
                    // nationality: selectedCountry,
                    title: selectedTitle,
                    healthCare: selectedHealthCare!.id!.toString(),
                    nokName: nokNameController.text,
                    nokPhoneNumber: nokPhoneNumberController.text,
                    nokRelationship: nokRelationshipController.text,
                    nokAddress: nokAddressController.text,
                    noOfDependants: noOfDependantController.text,
                    maritalStatus: selectedMaritalStatus,
                    hypertensive: selectedHypertensiveStatus,
                    sickleCell: selectedSickleCellStatus,
                    cancer: selectedCancerStatus,
                    kidneyIssue: selectedKidneyStatus,
                    category: selectedCategory!.id!.toString(),
                    genotype: selectedGenotype,
                    existingMedicalCondition: selectedExistingMedicalConditionStatus,
                    stateId: selectedState!.id!.toString(),
                    lastName: lastNameController.text.trim(),
                    middleName: middleNameController.text.trim(),
                    lgId: selectedLga!.id!.toString(),
                      dateRegistered: DateTime.now()

                  );

                  Navigator.push(context, MaterialPageRoute(builder: (context) => EnrollmentDetails(offlineEnrolleeData: offlineEnrollee,)));
                }else{

                }

              }, AppStrings.nextPage,
                  emailEditingController.text.trim().isNotEmpty && middleNameController.text.trim().isNotEmpty && phoneNumberEditingController.text.trim().isNotEmpty && contactAddressEditingController.text.trim().isNotEmpty && dobEditingController.text.trim().isNotEmpty && selectedState != null && contactAddressEditingController.text.trim().isNotEmpty && selectedBloodGroup != null && selectedMaritalStatus != null && selectedHypertensiveStatus != null && selectedSickleCellStatus != null && selectedSickleCellStatus != null && selectedCancerStatus != null && selectedKidneyStatus != null && selectedCategory != null && selectedHealthCare != null && selectedGenotype != null && selectedExistingMedicalConditionStatus != null && nokNameController.text.trim().isNotEmpty && nokPhoneNumberController.text.isNotEmpty && nokAddressController.text.isNotEmpty && nokRelationshipController.text.trim().isNotEmpty? ColorManager.primaryColor : ColorManager.disabledButtonColor,
                  emailEditingController.text.trim().isNotEmpty && middleNameController.text.trim().isNotEmpty && phoneNumberEditingController.text.trim().isNotEmpty && contactAddressEditingController.text.trim().isNotEmpty && dobEditingController.text.trim().isNotEmpty && selectedState != null && contactAddressEditingController.text.trim().isNotEmpty && selectedBloodGroup != null && selectedMaritalStatus != null && selectedHypertensiveStatus != null && selectedSickleCellStatus != null && selectedSickleCellStatus != null && selectedCancerStatus != null && selectedKidneyStatus != null && selectedCategory != null && selectedHealthCare != null && selectedGenotype != null && selectedExistingMedicalConditionStatus != null && nokNameController.text.trim().isNotEmpty && nokPhoneNumberController.text.isNotEmpty && nokAddressController.text.isNotEmpty && nokRelationshipController.text.trim().isNotEmpty ? ColorManager.whiteColor : ColorManager.disabledButtonTextColor),
            ],
          )),
    );
  }
}
