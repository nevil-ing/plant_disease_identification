import 'package:hive/hive.dart';

part 'disease_info.g.dart';

@HiveType(typeId: 0)
class DiseaseInfo {
  @HiveField(0)
  final String causes;
  @HiveField(1)
  final String effects;
  @HiveField(2)
  final String prevention;

  DiseaseInfo({
    required this.causes,
    required this.effects,
    required this.prevention,
  });
}
