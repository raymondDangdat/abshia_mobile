import 'package:abshia/models/book_appointment_model.dart';
import 'package:abshia/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../providers/helper_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/reusable_widget.dart';



class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key,

  }) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final appointmentTitleController = TextEditingController();
  final appointmentReasonController = TextEditingController();
  final appointmentDateController = TextEditingController();

  @override
  void initState() {
    setState(() {
    });
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

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
        appointmentDateController.text = dob;
      });
    }
  }

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
                        child: CustomTextWithLineHeight(text: AppStrings.makeAppointment, fontSize: FontSize.s21, lineHeight: 1.2, textColor: ColorManager.primaryColor, fontWeight: FontWeightManager.bold,),)
                    ],
                  ),),

                SizedBox(height: AppSize.s17.h,),


                SizedBox(width: AppSize.s364.h,
                  child: CustomTextWithLineHeight(
                    isCenterAligned: false,
                    text: AppStrings.fillTheFormBelow, fontSize: FontSize.s16, lineHeight: 1.2, textColor: ColorManager.faintTextColor, fontWeight: FontWeightManager.regular,),),

                SizedBox(height: AppSize.s30.h,),

                TextFormField(
                  controller: appointmentTitleController,
                  autofocus: false,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  obscuringCharacter: AppStrings.obscureCharacter,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    label: requiredHint(AppStrings.titleLabel),
                    hintText: AppStrings.titleOfTheAppointment,
                  ),
                ),

                SizedBox(height: AppSize.s16.h,),

                TextFormField(
                  controller: appointmentReasonController,
                  autofocus: false,
                  maxLines: 6,
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    label: requiredHint(AppStrings.appointmentReason),
                    hintText: AppStrings.reasons,
                  ),
                ),

                SizedBox(height: AppSize.s16.h,),

                TextFormField(
                  controller: appointmentDateController,
                  autofocus: false,
                  maxLines: 1,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("[0-9/]")),
                  ],
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    label: requiredHint(AppStrings.appointmentDate),
                    hintText: AppStrings.appointmentDateHint,
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

                SizedBox(height: AppSize.s54.h,),

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
                    return customElevatedButton(context, (){
                      if(appointmentTitleController.text.trim().isEmpty || appointmentReasonController.text.trim().isEmpty || appointmentDateController.text.trim().isEmpty){
                      //  DO nothing
                      }else{
                      //  Book appointment
                        final newAppointment = BookAppointmentModel(
                          title: appointmentTitleController.text.trim(),
                          appointmentReason: appointmentReasonController.text.trim(),
                          appointmentDate: selectedDate,

                        );

                        helper.bookAppointment(context, newAppointment, auth.enrolleeUser.token!);
                      }
                    }, AppStrings.submit,
                      appointmentTitleController.text.trim().isEmpty || appointmentReasonController.text.trim().isEmpty || appointmentDateController.text.trim().isEmpty ? ColorManager.disabledButtonColor : ColorManager.primaryColor,
                      ColorManager.whiteColor,);
                  }
                ),
              ],
            ),
          )),
    );
  }
}
