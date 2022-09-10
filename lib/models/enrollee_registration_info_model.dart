import 'package:abshia/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';

class EnrolleeRegInfoModel{
  final String title;
  final int value;
  final Color titleColor;
  final Color valueTextColor;
  final Color bgColor;

  EnrolleeRegInfoModel({required this.title, required this.value, required this.titleColor, required this.valueTextColor, required this.bgColor});
}

List<EnrolleeRegInfoModel> enrolleeInfo = [
  EnrolleeRegInfoModel(title: "Total Registration", value: 100, valueTextColor: Color.fromRGBO(224, 159, 31, 1), titleColor: ColorManager.whiteColor, bgColor: ColorManager.primaryColor),
  EnrolleeRegInfoModel(title: "Offline registration", value: 400, valueTextColor: ColorManager.primaryColor, titleColor: Color.fromRGBO(123, 141, 158, 1), bgColor: ColorManager.cardColor),

];