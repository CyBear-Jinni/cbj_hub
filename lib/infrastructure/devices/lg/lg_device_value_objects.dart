import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_device_validators.dart';
import 'package:dartz/dartz.dart';

/// Lg communication port
class LgPort extends ValueObjectCore<String> {
  factory LgPort(String? input) {
    assert(input != null);
    return LgPort._(
      validateLgPortNotEmpty(input!),
    );
  }

  const LgPort._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
