import 'package:abshia/resources/strings_manager.dart';
import 'package:abshia/screens/forgot_password/forgot_password_screen.dart';
import 'package:abshia/screens/navigation_screen/nav_screen.dart';
import 'package:abshia/screens/self_enrollment/book_appointment/book_appointment.dart';
import 'package:abshia/screens/self_enrollment/enrollee_payment_successful/enrollee_payment_successfull.dart';
import 'package:abshia/screens/self_enrollment/enrollment_flow/user_personal_details.dart';
import 'package:abshia/screens/self_enrollment/nav_screen/user_nav_screen.dart';
import 'package:abshia/screens/user_enrollment_flow/offline_registration_completed.dart';
import 'package:flutter/material.dart';

import '../screens/change_password/change_password_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/options_screen/options_screen.dart';
import '../screens/self_enrollment/login_screen_user/login_screen_user.dart';
import '../screens/self_enrollment/sign_up_user/sign_up_user_screen.dart';
import '../screens/self_enrollment/user_change_password/user_change_password.dart';
import '../screens/splash_screen/SplashView.dart';
import '../screens/user_enrollment_flow/payment_successful.dart';
import '../screens/user_enrollment_flow/personal_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String optionScreen = "/options_screen";
  static const String signInView = "/sign_in";
  static const String changePassword = "/change_password";
  static const String userChangePassword = "/user_change_password";
  static const String forgotPassword = "/forgot_password";
  static const String navScreen = "/nav_screen";
  static const String userNavScreen = "/user_nav_screen";
  static const String personalDetails = "/personal_details";
  static const String enrolleeDetails = "/enrollee_details";
  static const String offlineRegistrationCompleted = "/offline_reg_completed";
  static const String selectSubPlan = "/select_sub_plan";
  static const String paymentSuccessful = "/payment_successful";
  static const String enrolleePaymentSuccessful = "/enrollee_payment_successful";
  static const String userLogin = "/user_login";
  static const String signupUserScreen = "/sign_up_user";
  static const userPersonalEnrollmentDetail = "/user_personal_enrollment";
  static const bookAppointment = "/book_appointment";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.optionScreen:
        return MaterialPageRoute(builder: (_) => const OptionsScreenView());
      case Routes.signInView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.userChangePassword:
        return MaterialPageRoute(builder: (_) => const UserChangePasswordScreen());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.navScreen:
        return MaterialPageRoute(builder: (_) => const NavScreen());
      case Routes.personalDetails:
        return MaterialPageRoute(builder: (_) => const PersonalDetails());
      // case Routes.enrolleeDetails:
      //   return MaterialPageRoute(builder: (_) => const EnrolleeDetails());
      case Routes.offlineRegistrationCompleted:
        return MaterialPageRoute(builder: (_) => const OfflineRegistrationCompleted());
      // case Routes.selectSubPlan:
      //   return MaterialPageRoute(builder: (_) => const SelectSubPlan());
      case Routes.paymentSuccessful:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessful());
      case Routes.enrolleePaymentSuccessful:
        return MaterialPageRoute(builder: (_) => const EnrolleePaymentSuccessful());
      case Routes.userLogin:
        return MaterialPageRoute(builder: (_) => const LoginScreenUser());
      case Routes.signupUserScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreenUser());
      case Routes.userPersonalEnrollmentDetail:
        return MaterialPageRoute(builder: (_) => const UserPersonalDetails());
      case Routes.userNavScreen:
        return MaterialPageRoute(builder: (_) => const UserNavScreen());
      case Routes.bookAppointment:
        return MaterialPageRoute(builder: (_) => const BookAppointment());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
