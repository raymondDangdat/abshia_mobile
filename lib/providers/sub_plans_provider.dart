import 'dart:convert';
import 'package:abshia/models/plans_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/endpoints.dart';
import '../resources/routes_manager.dart';
import '../widgets/loading.dart';
import 'dosposable_provider.dart';


class SubPlanProvider extends DisposableProvider {

  List<SubscriptionPlan> _plans = [];
  List<SubscriptionPlan> get plans => _plans;

  bool _isLoading = false;
  String _resMessage = '';


  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

  Future<List<SubscriptionPlan>> getSubscriptionPlan(
      BuildContext context, String token) async {
    print("Method called");
    String _url =
        "$baseURL${Endpoints.plans}";
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
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },);
      // print("Response body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final planModel = plansModelFromJson(response.body);

        _plans = planModel.data!;
        print("Length of of plans: ${_plans.length}");
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
    return _plans;
  }




  @override
  void disposeValues() {
    notifyListeners();
  }
}
