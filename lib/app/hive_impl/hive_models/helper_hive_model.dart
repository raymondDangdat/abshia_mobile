import 'package:hive/hive.dart';

import '../../../models/helper_model.dart';

part 'helper_hive_model.g.dart';

@HiveType(typeId: 3)
class HelperHiveModel {
  HelperHiveModel({
    required this.id,
    required this.helper,
  });
  @HiveField(0)
  String? id;
  @HiveField(1)
  HelperModel? helper;

}
