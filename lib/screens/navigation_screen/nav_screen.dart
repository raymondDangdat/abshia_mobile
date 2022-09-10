import 'package:abshia/screens/home/home_screen.dart';
import 'package:abshia/screens/menu/menu_screen.dart';
import 'package:abshia/screens/offline_registration/offline_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/reusable_widget.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OfflineRegistration(),
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     WidgetsBinding.instance!.addPostFrameCallback((_) {
    //       show(context);
    //     });
    //   });
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.whiteColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          enableFeedback: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.homeInActiveIcon),
              ),
              label: AppStrings.home,
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.homeActiveIcon),
              ),
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon:Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.offlineInActiveIcon),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.offlineActiveIcon),
              ),
              label: AppStrings.offlineReg,
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.menuIcon),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: AppSize.s10.h, top: AppSize.s16.h),
                child: SvgPicture.asset(AppImages.menuIcon, color: ColorManager.primaryColor,),
              ),
              label: AppStrings.menu,
              // backgroundColor: Colors.purple,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorManager.blackTextColor,
          unselectedItemColor: ColorManager.unselectedItemsColor,
          onTap: _onItemTapped,
        ),
    );
  }

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s25.r),
        height: AppSize.s366.h,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s30.r),
              topRight: Radius.circular(AppSize.s30.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: AppSize.s61.h,
            ),

            SizedBox(height: AppSize.s61.h,
              child: CustomTextWithLineHeight(text: AppStrings.proceedToUpdate, fontSize: FontSize.s16, lineHeight: 1.5,),
            ),
            SizedBox(height: AppSize.s31.h,),

            customElevatedButton(context, () {
              Navigator.pop(context);
            }, AppStrings.skip, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),

            SizedBox(
              height: AppSize.s12.h,
            ),

            customElevatedButton(context, () {
              Navigator.pop(context);
            }, AppStrings.conntinue, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }
}
