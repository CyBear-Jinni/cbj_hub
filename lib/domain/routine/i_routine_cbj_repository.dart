import 'package:cbj_hub/domain/local_db/local_db_failures.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_failures.dart';
import 'package:dartz/dartz.dart';

abstract class IRoutineCbjRepository {
  Future<List<RoutineCbjEntity>> getAllRoutinesAsList();

  Future<Map<String, RoutineCbjEntity>> getAllRoutinesAsMap();

  /// Sending the new routine to the hub to get added
  Future<Either<RoutineCbjFailure, Unit>> addNewRoutine(
    RoutineCbjEntity routineCbj,
  );

  Future<Either<LocalDbFailures, Unit>> saveAndActivateRoutineToDb();

  Future<bool> activateRoutine(
    RoutineCbjEntity routineCbj,
  );

  /// Get entity and return the full MQTT path to it
  Future<String> getFullMqttPathOfRoutine(RoutineCbjEntity routineCbj);
}
