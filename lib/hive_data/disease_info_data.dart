import 'package:hive/hive.dart';

import '../models/disease_info.dart';
import 'hive_box_constant.dart';

class HiveFunctions {
  //box to store disease
  static final maizeRustBox = Hive.box(rustHiveBox);
  //maize rust data
  var maizeDiseaseInfo =
      DiseaseInfo(causes: 'causes', effects: 'weird', prevention: 'nevil');
  //add data to rust hive box
  addMaizeRust() {
    maizeRustBox.addAll(maizeDiseaseInfo as Iterable);
  }

  //Get all Maize rust data
  static getMaizeRustData() async {
    return await maizeRustBox.get([1, 2, 3]);
  }
}
