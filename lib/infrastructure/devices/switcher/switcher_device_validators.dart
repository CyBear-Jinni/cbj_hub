import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateSwitcherIdNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateSwitcherPortNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateSwitcherMacAddressNotEmpty(
  String input,
) {
  return right(input);
}
