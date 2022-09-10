import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';

Widget customTextField(
    {TextEditingController? controller,
      bool autoFocus = false,
      bool obSecureText = false,
      int? maxLines = 1,
      String hint = "",
      String? labelText,
      // double height = 40,
    }) {
  return Column(
    children: [
      Container(
        // height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: ColorManager.textFilledColor,
        ),
        alignment: Alignment.center,
        child: TextFormField(
              controller: controller,
              autofocus: autoFocus,
              maxLines: maxLines,
              obscureText:  false,

              decoration: InputDecoration(
                // suffixIcon: obSecureText ? InkWell(
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   onTap: (){
                //     obSecureText = !obSecureText;
                //   },
                //     child: Icon(auth.visiblePassword ? Icons.visibility_off : Icons.visibility)) : SizedBox.shrink(),

                hintText: hint,
                labelText: labelText,
              ),
            )

      ),

    ],
  );
}
