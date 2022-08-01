import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_device_validators.dart';
import 'package:dartz/dartz.dart';

/// TasmotaIp device unique address that came withe the device
class TasmotaIpDeviceTopicName extends ValueObjectCore<String> {
  factory TasmotaIpDeviceTopicName(String? input) {
    assert(input != null);
    return TasmotaIpDeviceTopicName._(
      validateTasmotaIpDeviceTopicNameNotEmpty(input!),
    );
  }

  const TasmotaIpDeviceTopicName._(this.value);

  @override
  final Either<CoreFailure<String>, String> value;
}
