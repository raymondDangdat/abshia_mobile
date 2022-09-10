import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

void showMessage({String? message, BuildContext? context, Color bgColor = Colors.blue}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: ColorManager.whiteColor),
      ),
      backgroundColor: bgColor));
}