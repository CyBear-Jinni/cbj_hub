import 'package:hive/hive.dart';

part 'bindings_hive_model.g.dart';

@HiveType(typeId: 7)
class BindingsHiveModel extends HiveObject {
  @HiveField(0)
  late String bindingsStringJson;
}
