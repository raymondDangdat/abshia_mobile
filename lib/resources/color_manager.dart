import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor = HexColor.fromHex("#1C6BA4");
  static Color textFilledColor = HexColor.fromHex("#EEF6FC");
  static Color overlayColor = Color.fromRGBO(28, 107, 164, 0.73);
  static Color agentContainerColor = Color.fromRGBO(220, 237, 249, 1);
  static Color userContainerColor = Color.fromRGBO(250, 240, 219, 1);
  static Color blackTextColor = Color.fromRGBO(14, 16, 18, 1);
  static Color disabledButtonColor = Color.fromRGBO(232, 235, 237, 1);
  static Color disabledButtonTextColor = Color.fromRGBO(123, 141, 158, 1);
  static Color categoryColor = Color.fromRGBO(220, 237, 249, 1);
  static Color dummyUserCardColor =  Color.fromRGBO(238, 246, 252, 1);
  static Color dummyUserTextColor = Color.fromRGBO(28, 35, 31, 1);
  static Color unselectedItemsColor = HexColor.fromHex("#364156");
  static Color boldTextColor = HexColor.fromHex("#2A2A2A");
  static Color yourBalanceTextColor = HexColor.fromHex("#364156");
  static Color filterColor = const Color.fromRGBO(114, 115, 118, 1);
  static Color cardShadow =  const Color.fromRGBO(54, 65, 86, 0.1);
  static Color menuItemsColor = HexColor.fromHex("#727376");
  static Color switchBgColor = HexColor.fromHex("#C4C4C4");
  static Color plansPriceColor = HexColor.fromHex("#686868");
  static Color yourBalanceContainerColor = const Color.fromRGBO(217, 219, 219, 0.25);
  static Color progressIndicatorBgColor = const Color.fromRGBO(216, 216, 216, 1);
  static Color faintWhite =  Color.fromRGBO(183, 198, 212, 1);
  static Color lightGreen =  Color.fromRGBO(54, 255, 183, 1);
  static Color lightTextColor = HexColor.fromHex("#657B9A");
  static Color whiteColor = HexColor.fromHex("#FFFFFF");
  static Color containerShadow = HexColor.fromHex("#2C3A4E14");
  static Color accentColor = HexColor.fromHex("#F1C00F");
  static Color greenColor = Color.fromRGBO(4, 140, 91, 1);
  static Color cardColor = HexColor.fromHex("#F3F4F7");
  static Color hintColor = HexColor.fromHex("#C1CAD7");
  static Color labelColor = HexColor.fromHex("#657B9A");
  static Color errorColor = HexColor.fromHex("#CC334F");
  static Color backButtonColor = HexColor.fromHex("#EEF3FB");
  static Color inputBorderColor = HexColor.fromHex("#E0E4EB");
  static Color faintTextColor = HexColor.fromHex("#8495AE");
  static Color fbBlueColor = HexColor.fromHex("#1977F3");
  static Color visitedPagesColor = HexColor.fromHex("#031F4C");
  static Color redColor = HexColor.fromHex("#FF0000");
  static Color blackColor = HexColor.fromHex("#031F4C");
  static Color dashboardItemsLightColor = HexColor.fromHex("#CCDCF4");
  static Color boldVtuBgColor = HexColor.fromHex("#F2EFFA");
  static Color boldVtuIconContainerColor = HexColor.fromHex("#4C30A0");
  static Color boldSecureVpnContainerColor = HexColor.fromHex("#ED7D31");
  static Color boldSecureVpnBgColor = HexColor.fromHex("#FDF3EC");
  static Color sendToCardColor = HexColor.fromHex("#173F82");





  static Color redeemContainerColor = HexColor.fromHex("#F3EEFC");
  static Color redeemPrimaryTextColor = HexColor.fromHex("#290F57");

  static Color payCardColor = HexColor.fromHex("#FAF3EF");
  static Color payTextPrimaryColor = HexColor.fromHex("#4E2C18");

  static Color sendContainerColor = HexColor.fromHex("#E9FBEB");
  static Color sendPrimaryText = HexColor.fromHex("#105618");

  static Color donateCardColor = HexColor.fromHex("#EEF3FB");
  static Color donatePrimaryTextColor = HexColor.fromHex("#0F2957");

  static Color boldAppsItemsOverlay1 = const Color.fromRGBO(0, 0, 0, 0.6);
  static Color boldAppsItemsOverlay2 = const Color.fromRGBO(0, 0, 0, 0);

  static Color settingsSpaceColor = HexColor.fromHex("#E5E5E5");


}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", '');

    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
