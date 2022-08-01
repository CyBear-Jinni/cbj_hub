import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_ip/tasmota_ip_led/tasmota_ip_led_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:injectable/injectable.dart';

@singleton
class TasmotaIpConnectorConjector implements AbstractCompanyConnectorConjector {
  static Map<String, DeviceEntityAbstract> companyDevices = {};

  // This is how you can interact tasmota using network calls.
  // http://ip/cm?cmnd=SetOption19%200
  // http://ip/cm?cmnd=MqttHost%200

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tasmotaIpDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaIpDE.getDeviceId()];

    if (device is TasmotaIpLedEntity) {
      device.executeDeviceAction(newEntity: tasmotaIpDE);
    } else {
      logger.w('TasmotaIp device type does not exist');
    }
  }
}
