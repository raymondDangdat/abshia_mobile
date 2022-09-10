
import 'package:abshia/app/hive_impl/hive_models/offline_enrollee_data.dart';
import 'package:abshia/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';




class OfflineEnrollmentProvider extends ChangeNotifier {
  List<OfflineEnrolleeData> _offlineEnrollees = [];


  List<OfflineEnrolleeData> get offlineEnrollees => _offlineEnrollees;
  Box<OfflineEnrolleeData> browsingHistoryHive = Hive.box(offlineEnrollee);


  void addOfflineEnrollee(OfflineEnrolleeData enrollee) {
    Hive.box<OfflineEnrolleeData>(offlineEnrollee)
        .put(enrollee.id, enrollee);
    _offlineEnrollees = browsingHistoryHive.values.toList().cast<OfflineEnrolleeData>();
    notifyListeners();
  }


  static Box<OfflineEnrolleeData> getOfflineEnrollee() =>
      Hive.box<OfflineEnrolleeData>(offlineEnrollee);
}
