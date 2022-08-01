import 'package:hive/hive.dart';

part 'rooms_hive_model.g.dart';

@HiveType(typeId: 3)
class RoomsHiveModel extends HiveObject {
  @HiveField(0)
  late String roomUniqueId;
  @HiveField(1)
  late String roomDefaultName;
  @HiveField(2)
  late List<String> roomDevicesId;
  @HiveField(3)
  late List<String> roomScenesId;
  @HiveField(4)
  late List<String> roomRoutinesId;
  @HiveField(5)
  late List<String> roomBindingsId;
  @HiveField(6)
  late List<String> roomMostUsedBy;
  @HiveField(7)
  late List<String> roomPermissions;
  @HiveField(8)
  late List<String> roomTypes;
}
