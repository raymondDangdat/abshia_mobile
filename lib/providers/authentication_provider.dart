import 'dart:convert';
import 'dart:io';
import 'package:abshia/app/hive_impl/hive_models/helper_hive_model.dart';
import 'package:abshia/constants/constants.dart';
import 'package:abshia/models/agent_profile.dart';
import 'package:abshia/models/enrollee_user.dart';
import 'package:abshia/models/user_%20model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/helper_model.dart';
import '../resources/color_manager.dart';
import '../resources/endpoints.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading.dart';
import '../widgets/reusable_widget.dart';
import 'helper_provider.dart';


class AuthenticationProvider extends ChangeNotifier {
  ///Setter
  bool _isLoading = false;
  bool _wrongOtp = false;
  String _resMessage = '';
  String _phoneNumber = "";
  final String _pin = "";
  AgentUser? _userdata;
  AgentProfile? _agentProfile;
  EnrolleeUser? _enrolleeUser;

  HelperModel? _helper;

  HelperHiveModel? _hiveHelperData;
  HelperHiveModel get helperData => _hiveHelperData!;



  ///Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  String get phoneNumber => _phoneNumber;
  HelperModel get helper => _helper!;
  EnrolleeUser get enrolleeUser => _enrolleeUser!;

  AgentUser get userData => _userdata!;
  AgentProfile get agentProfile => _agentProfile!;


  bool get wrongOtp => _wrongOtp;
  String get pin => _pin;

  HelperProvider helperProvider = HelperProvider();

  set phoneNumber(String value) {
    if (value != _phoneNumber) {
      _phoneNumber = value;
      notifyListeners();
    }
  }

  //Login
  void loginAgent({
    required String email,
    required String password,
    required BuildContext context,
    required bool isAgent,
  }) async {
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {"email": email, "password": password};
    try {
      final response =
      await http.post(Uri.parse("$baseURL${Endpoints.login}"), body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        final res = json.decode(response.body);
        final userRole = res['user']["role"];
        if(userRole == "user"){
          _isLoading = false;
          _resMessage = "Only Agents are authorized here";
          notifyListeners();
          Navigator.pop(context);
        }else{
          _userdata = agentUserFromJson(response.body);
          _isLoading = false;
          _resMessage = "";
          notifyListeners();
          Navigator.pop(context);
          await getHelpers(context);
          await getAgentProfile(context);
          if(password == "password"){
            showLoginSuccess(context);
          }else{
            Navigator.pushNamed(context, Routes.navScreen);

          }
        }

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        // print(res);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      print("Agent Login Exception: $e");
    }
  }



  //Login
  void enrolleeLogin({
    required String email,
    required String password,
    required BuildContext context,
    required bool isAgent,
  }) async {
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
      "password": password,
    };
    try {
      final response =
      await http.post(Uri.parse("$baseURL${Endpoints.login}"), body: body);
      // print("Enrollee Login Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _enrolleeUser = enrolleeUserFromJson(response.body);
        _isLoading = false;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
        if(_enrolleeUser!.user!.details!.nokName!.isEmpty || _enrolleeUser!.user!.details!.phoneNumber!.isEmpty){
          await getHelpers(context);
          Navigator.pushReplacementNamed(context, Routes.userPersonalEnrollmentDetail);
        }else{
          if(password == "password"){
            showUserLoginSuccess(context);
          }else{
            await getHelpers(context);
            Navigator.pushReplacementNamed(context, Routes.userNavScreen);
          }
        }

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        // print(res);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }

  //Sign up
  void userSignup({
    required String email,
    required String password,
    required BuildContext context,
    required String surname,
  }) async {
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "email": email,
      "password": password,
      "surname": surname
    };
    try {
      final response = await http.post(Uri.parse("$baseURL${Endpoints.enrolleeSignup}"), body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
            Navigator.pushReplacementNamed(context, Routes.userLogin);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }

  //Change Password
  void changePassword({
    required String oldPassword,
    required String password,
    required String password_confirmation,
    required BuildContext context,
    required bool isAgent,
    required String token,
  }) async {
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "old_password" : oldPassword,
      "password" :  password,
      "password_confirmation" : password_confirmation,
    };
    try {
      final response = await http.patch(Uri.parse("$baseURL${Endpoints.changePassword}"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      // print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
        if(isAgent){
          await getHelpers(context);
          if(password == "password"){
            showUserLoginSuccess(context);
          }else{
            Navigator.pushNamed(context, Routes.navScreen);

          }

        }else{
          await getHelpers(context);
          // Navigator.pushNamed(context, Routes.userPersonalEnrollmentDetail);
          Navigator.pushNamed(context, Routes.userNavScreen);
        }
      } else if (response.statusCode == 422) {
        _resMessage = "Wrong old password";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        // print(res);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }

  //Change Password Agent
  void changeAgentPassword({
    required String oldPassword,
    required String password,
    required String password_confirmation,
    required BuildContext context,
    required String token,
  }) async {
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    final body = {
      "old_password" : oldPassword,
      "password" :  password,
      "password_confirmation" : password_confirmation,
    };
    try {
      final response = await http.patch(Uri.parse("$baseURL${Endpoints.changePassword}"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
        await getHelpers(context);
        Navigator.pushNamed(context, Routes.navScreen);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        // print(res);
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }


  Future<HelperModel?> getHelpers(
      BuildContext context) async {
    String _url =
        "$baseURL${Endpoints.createHelper}";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    try {
      final response = await http
          .get(Uri.parse(_url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        _helper = createHelperFromJson(response.body);

        if (Hive.box<HelperHiveModel>(offlineHelpers).isNotEmpty) {
          _hiveHelperData = Hive.box<HelperHiveModel>(offlineHelpers).getAt(0);
        }


        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
        // Navigator.pushNamed(context, Routes.personalDetails);
      } else if (response.statusCode == 403) {
        _resMessage = "Session Expired, login";
        notifyListeners();
        Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        // print("Faild Response: ${response.body} ${response.statusCode}");
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      notifyListeners();
      Navigator.pop(context);
    }

    return _helper;
  }


  Future<AgentProfile?> getAgentProfile(
      BuildContext context) async {
    String _url =
        "$baseURL${Endpoints.agentProfile}";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    try {
      final response = await http
          .get(Uri.parse(_url),
        headers: {
          'Authorization': 'Bearer ${_userdata!.token!}',
          'Content-Type': 'application/json',
        },);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _agentProfile = agentProfileFromJson(response.body);
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
        // Navigator.pushNamed(context, Routes.personalDetails);
      } else if (response.statusCode == 403) {
        _resMessage = "Session Expired, login";
        notifyListeners();
        Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        // print("Faild Response: ${response.body} ${response.statusCode}");
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      notifyListeners();
      Navigator.pop(context);
    }

    return _agentProfile;
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

  void showUserLoginSuccess(BuildContext ctx) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s25.r),
        height: AppSize.s397.h,
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
              height: AppSize.s30.h,
            ),
            SvgPicture.asset(AppImages.loginSuccessIcon),
            SizedBox(
              height: AppSize.s35.h,
            ),
            Container(height: AppSize.s62.h,
              child: Column(
                children: [
                  CustomTextWithLineHeight(text: AppStrings.signInSuccessful, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                  CustomTextWithLineHeight(text: AppStrings.startChangingYour, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                ],
              ),
            ),
            SizedBox(height: AppSize.s40.h,),
            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.userNavScreen);
            }, AppStrings.skip, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),
            SizedBox(
              height: AppSize.s12.h,
            ),
            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.userChangePassword);
            }, AppStrings.conntinue, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }

  void showLoginSuccess(BuildContext ctx) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s25.r),
        height: AppSize.s397.h,
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
              height: AppSize.s30.h,
            ),
            SvgPicture.asset(AppImages.loginSuccessIcon),
            SizedBox(
              height: AppSize.s35.h,
            ),
            Container(height: AppSize.s62.h,
              child: Column(
                children: [
                  CustomTextWithLineHeight(text: AppStrings.signInSuccessful, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                  CustomTextWithLineHeight(text: AppStrings.startChangingYour, fontSize: FontSize.s16, lineHeight: 1.5, isCenterAligned: true,),
                ],
              ),
            ),
            SizedBox(height: AppSize.s40.h,),
            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.navScreen);
            }, AppStrings.skip, ColorManager.disabledButtonColor,
                ColorManager.disabledButtonTextColor),
            SizedBox(
              height: AppSize.s12.h,
            ),
            customElevatedButton(context, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.changePassword);
            }, AppStrings.conntinue, ColorManager.primaryColor,
                ColorManager.whiteColor),
          ],
        ),
      ),
    );
  }
}
