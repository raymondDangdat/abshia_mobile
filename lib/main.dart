import 'package:abshia/app/hive_impl/hive_models/helper_hive_model.dart';
import 'package:abshia/providers/authentication_provider.dart';
import 'package:abshia/providers/offline_data_provider.dart';
import 'package:abshia/resources/share_prefs/local_user_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/app.dart';
import 'app/hive_impl/hive_models/offline_enrollee_data.dart';
import 'constants/constants.dart';
import 'providers/helper_provider.dart';
import 'providers/sub_plans_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(OfflineEnrolleeDataAdapter())
  ..registerAdapter(HelperHiveModelAdapter());

  await Hive.openBox<OfflineEnrolleeData>(offlineEnrollee);
  await Hive.openBox<HelperHiveModel>(offlineHelpers);


  await LocalUserData.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (_) => HelperProvider(),),
      ChangeNotifierProvider(create: (_) => OfflineEnrollmentProvider()),
      ChangeNotifierProvider(create: (_) => SubPlanProvider()),

    ],
    child: const MyApp(),
  ));
}

