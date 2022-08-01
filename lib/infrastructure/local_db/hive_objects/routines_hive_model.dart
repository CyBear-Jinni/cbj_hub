import 'package:hive/hive.dart';

part 'routines_hive_model.g.dart';

@HiveType(typeId: 6)
class RoutinesHiveModel extends HiveObject {
  @HiveField(0)
  late String routinesStringJson;
}
