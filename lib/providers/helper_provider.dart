import 'dart:convert';
import 'package:abshia/models/book_appointment_model.dart';
import 'package:abshia/models/local_government_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app/hive_impl/hive_models/offline_enrollee_data.dart';
import '../models/enrolled_user_model.dart';
import '../models/enrollee_data_model.dart';
import '../models/plans_model.dart';
import '../resources/endpoints.dart';
import '../resources/routes_manager.dart';
import '../widgets/loading.dart';
import 'dosposable_provider.dart';


class HelperProvider extends DisposableProvider {
  LocalGovernmentModel? _lgas;
  EnrolleeDataModel? _enrolleeData;

  bool _isLoading = false;
  String _resMessage = '';

  EnrolledUserModel? _enrolledUserData;


  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  LocalGovernmentModel get helper => _lgas!;
  EnrolleeDataModel get enrolleeData => _enrolleeData!;



  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

  Future<LocalGovernmentModel?> getLgas(
      BuildContext context, String stateId) async {
    String _url =
        "$baseURL${Endpoints.lgHelper}$stateId";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    try {
      final response = await http
          .get(Uri.parse(_url));
      // print("Response body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _lgas = localGovernmentModelFromJson(response.body);
        _isLoading = false;
        _resMessage = "";
        notifyListeners();
        Navigator.pop(context);
      } else if (response.statusCode == 403) {
        _resMessage = "Session Expired, login";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        // print("Faild Response: ${response.body} ${response.statusCode}");
        _resMessage = json.decode(response.body)['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    }

    return _lgas;
  }


  Future<bool> enrollUser(
      BuildContext context,
      OfflineEnrolleeData offlineEnrolleeData,
      String token, String agentCode,
      SubscriptionPlan selectedSubPlan,
      ) async {
    bool enrolled = false;
    String _url = "$baseURL${Endpoints.enrollUser}";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();

    final body = {
      "title" : offlineEnrolleeData.title,
      "email" : offlineEnrolleeData.email,
      "phone_number" : offlineEnrolleeData.phoneNumber,
      "address" : offlineEnrolleeData.contactAddress,
      "surname" : offlineEnrolleeData.firstName,
      "first_name" : offlineEnrolleeData.firstName,
      "middle_name" : offlineEnrolleeData.firstName,
      "gender" : offlineEnrolleeData.gender,
      "dob" : offlineEnrolleeData.dob,
      "blood_group" : offlineEnrolleeData.bloodGroup,
      "town" : "Town",
      "nok_name" : offlineEnrolleeData.nokName,
      "nok_address" : offlineEnrolleeData.nokAddress,
      "nok_relationship" : offlineEnrolleeData.nokRelationship,
      "nok_phone" : offlineEnrolleeData.nokPhoneNumber,
      "category_id" : offlineEnrolleeData.category,
      "mda_school_name" : "None",
      "health_care_id" : offlineEnrolleeData.healthCare,
      "existing_medical_condition" : offlineEnrolleeData.existingMedicalCondition  == "No" ? 0 : 1,
      "hypertension": offlineEnrolleeData.hypertensive  == "No" ? 0 : 1,
      "sickle_cell": offlineEnrolleeData.sickleCell  == "No" ? 0 : 1,
      "cancer": offlineEnrolleeData.cancer  == "No" ? 0 : 1,
      "state_id": offlineEnrolleeData.stateId,
      "lga_id": offlineEnrolleeData.lgId,
      "agent_code": agentCode,
      "genotype": offlineEnrolleeData.genotype,
      "marital_status": offlineEnrolleeData.maritalStatus,
      "no_of_dependants": offlineEnrolleeData.noOfDependants,
      "kidney_issue": offlineEnrolleeData.kidneyIssue == "No" ? 0 : 1,
    };

    try {
      final response = await http.post(Uri.parse(_url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print("Response Body: ${response.body} Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        _enrolledUserData = enrolledUserModelFromJson(response.body);

        final paymentUpdated =  await updatePayment(context, selectedSubPlan, token);
        if(paymentUpdated){
          enrolled = true;
        }else{
          _resMessage = "Could not update Payment";
        }
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.paymentSuccessful);

      } else if (response.statusCode == 403) {
        _isLoading = false;
        _resMessage = "Session Expired, login";
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        _isLoading = false;
        _resMessage = json.decode(response.body)['message'];
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      // print("Error: ${e.toString()}");
      _isLoading = false;

      notifyListeners();
      Navigator.pop(context);
    }

    return enrolled;
  }

  Future<bool> updateEnrollmentDetail(
      BuildContext context,
      OfflineEnrolleeData offlineEnrolleeData,
      String token, String agentCode,
      SubscriptionPlan selectedSubPlan,
      ) async {
    bool enrolled = false;
    String _url = "$baseURL${Endpoints.updateProfile}";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();

    final body = {
      "title" : offlineEnrolleeData.title,
      // "email" : offlineEnrolleeData.email,
      "phone_number" : offlineEnrolleeData.phoneNumber,
      "address" : offlineEnrolleeData.contactAddress,
      // "surname" : offlineEnrolleeData.firstName,
      "first_name" : offlineEnrolleeData.firstName,
      "middle_name" : offlineEnrolleeData.firstName,
      "gender" : offlineEnrolleeData.gender,
      "dob" : offlineEnrolleeData.dob,
      "blood_group" : offlineEnrolleeData.bloodGroup,
      "town" : "Town",
      "nok_name" : offlineEnrolleeData.nokName,
      "nok_address" : offlineEnrolleeData.nokAddress,
      "nok_relationship" : offlineEnrolleeData.nokRelationship,
      "nok_phone" : offlineEnrolleeData.nokPhoneNumber,
      "category_id" : offlineEnrolleeData.category,
      "mda_school_name" : "None",
      "health_care_id" : offlineEnrolleeData.healthCare,
      "existing_medical_condition" : offlineEnrolleeData.existingMedicalCondition  == "No" ? 0 : 1,
      "hypertension": offlineEnrolleeData.hypertensive  == "No" ? 0 : 1,
      "sickle_cell": offlineEnrolleeData.sickleCell  == "No" ? 0 : 1,
      "cancer": offlineEnrolleeData.cancer  == "No" ? 0 : 1,
      "state_id": offlineEnrolleeData.stateId,
      "lga_id": offlineEnrolleeData.lgId,
      "agent_code": agentCode,
      "genotype": offlineEnrolleeData.genotype,
      "marital_status": offlineEnrolleeData.maritalStatus,
      "no_of_dependants": offlineEnrolleeData.noOfDependants,
      "kidney_issue": offlineEnrolleeData.kidneyIssue == "No" ? 0 : 1,
    };

    try {
      final response = await http.patch(Uri.parse(_url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print("Response Body: ${response.body} Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        // enrolled = true;
        // Navigator.pop(context);
        // Navigator.pushNamed(context, Routes.paymentSuccessful);
        _enrolledUserData = enrolledUserModelFromJson(response.body);
        final paymentUpdated =  await updatePayment(context, selectedSubPlan, token);
        if(paymentUpdated){
          enrolled = true;
        }else{
          _resMessage = "Could not update Payment";
        }
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.enrolleePaymentSuccessful);
      } else if (response.statusCode == 403) {
        _isLoading = false;
        _resMessage = "Session Expired, login";
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        _isLoading = false;
        _resMessage = json.decode(response.body)['message'];
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      // print("Error: ${e.toString()}");
      _isLoading = false;

      notifyListeners();
      Navigator.pop(context);
    }

    return enrolled;
  }


  Future<bool> bookAppointment(
      BuildContext context,
      BookAppointmentModel appointmentModel,
      String token) async {
    bool enrolled = false;
    String _url = "$baseURL${Endpoints.bookAppointment}";
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();

    try {
      final request = await http.post(Uri.parse(_url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(appointmentModel.toJson()));
      print("Response Body: ${request.body}");
      if (request.statusCode == 200 || request.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.enrolleePaymentSuccessful);
        notifyListeners();
      } else if (request.statusCode == 403) {
        _isLoading = false;
        _resMessage = "Session Expired, login";
        notifyListeners();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.signInView);
      } else {
        _isLoading = false;
        _resMessage = json.decode(request.body)['message'];
        print("The message here: $_resMessage");
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      // print("Error: ${e.toString()}");
      _isLoading = false;

      notifyListeners();
      Navigator.pop(context);
    }

    return enrolled;
  }

  Future<bool> updatePayment(
      BuildContext context,
      SubscriptionPlan selectedSubPlan,
      String token) async {
    String _url = "$baseURL${Endpoints.makePayment}";
    _isLoading = true;
    bool paymentUpdated = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();

    final body =
    {
      "emp_id" : "${_enrolledUserData?.data!.id}",
      "plan_id" : selectedSubPlan.id,
      "type" : "monthly sub",
      "amount" : selectedSubPlan.cost,
      "description" : "${selectedSubPlan.description}"
    };

    print("Payload: $body");

    try {
      final request = await http.post(Uri.parse(_url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print("Make Payment Response Body: ${request.body}");
      if (request.statusCode == 200 || request.statusCode == 201) {
        _isLoading = false;
        _resMessage = "";
        paymentUpdated = true;
        Navigator.pop(context);
        notifyListeners();
      } else {
        _isLoading = false;
        _resMessage = json.decode(request.body)['message'];
        print("The message here: $_resMessage");
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      // print("Error: ${e.toString()}");
      _isLoading = false;

      notifyListeners();
      Navigator.pop(context);
    }

    return paymentUpdated;
  }



  @override
  void disposeValues() {
    notifyListeners();
  }
}
