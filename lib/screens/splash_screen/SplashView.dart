import 'dart:async';
import 'package:abshia/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

    @override
    _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
    Timer? _timer;

    _startDelay(){
        _timer = Timer(const Duration(seconds: 3), _goNext);
    }


    _goNext(){
        Navigator.pushReplacementNamed(context, Routes.optionScreen);
    }

    @override
    void initState() {
        super.initState();
        _startDelay();
    }

    @override
    void dispose() {
        _timer?.cancel();
        super.dispose();
    }
    @override
    Widget build(BuildContext context) {
        return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppImages.splashBgImage), fit: BoxFit.cover)
                  ),
                  child: Container(
                    color: ColorManager.overlayColor,
                    child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s213.h,
                      ),
        Container(
          height: AppSize.s250.h,
          width: AppSize.s264.h,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.abshia))
          ),
        ),
                      SizedBox(height: AppSize.s25.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
                          child: SizedBox(
                            // height: AppSize.s96.h,
                            child: CustomTextWithLineHeight(text: AppStrings.abiaStateHealthInsuranceScheme,textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s36,),
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.s25.r),
                        child: SizedBox(
                          // height: AppSize.s96.h,
                          child: CustomTextWithLineHeight(text: AppStrings.abshia, textColor: ColorManager.whiteColor, fontWeight: FontWeightManager.bold, fontSize: FontSize.s36,),
                        ),
                      ),


          ],
        ),),);
    }
}
