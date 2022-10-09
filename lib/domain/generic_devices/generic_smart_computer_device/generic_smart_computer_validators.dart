import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateGenericSmartComputerStateNotEmpty(
  String input,
) {
  return right(input);
}

/// Return all the valid actions for blinds
List<String> smartComputerAllValidActions() {
  return [
    DeviceActions.suspend.toString(),
    DeviceActions.shutdown.toString(),
    DeviceActions.itIsFalse.toString(),
  ];
}
