import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_rgbw_light_device/generic_rgbw_light_value_objects.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_light/shelly_light_entity.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_relay_switch/shelly_relay_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:cbj_hub/utils.dart';

class ShellyHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdDevice({
    required String mDnsName,
    required String? port,
    required String ip,
  }) async {
    final List<DeviceEntityAbstract> deviceEntityList = [];

    try {
      if (mDnsName.contains('colorbulb')) {
        final ShellyColorLightEntity shellyColorLightEntity =
            ShellyColorLightEntity(
          uniqueId: CoreUniqueId(),
          vendorUniqueId: VendorUniqueId.fromUniqueString(mDnsName),
          defaultName: DeviceDefaultName(mDnsName),
          deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
          senderDeviceOs: DeviceSenderDeviceOs('Shelly'),
          senderDeviceModel: DeviceSenderDeviceModel('d1'),
          senderId: DeviceSenderId(),
          compUuid: DeviceCompUuid('34asdfrsd23gggg'),
          stateMassage: DeviceStateMassage('Hello World'),
          powerConsumption: DevicePowerConsumption('0'),
          lightSwitchState: GenericRgbwLightSwitchState('off'),
          lightColorTemperature: GenericRgbwLightColorTemperature(
            '5482', // Check if value is ok example turn=on&red=254&green=14&blue=16&white=0
          ),
          lightBrightness: GenericRgbwLightBrightness(
            '100', // Check if value is ok
          ),
          lightColorAlpha: GenericRgbwLightColorAlpha('1.0'),
          lightColorHue: GenericRgbwLightColorHue('0.0'),
          lightColorSaturation: GenericRgbwLightColorSaturation('1.0'),
          lightColorValue: GenericRgbwLightColorValue('1.0'),
          devicePort: DevicePort(port),
          hostName: mDnsName.toLowerCase(),
          deviceMdnsName: DeviceMdnsName(mDnsName),
          lastKnownIp: DeviceLastKnownIp(ip),
        );
        deviceEntityList.add(shellyColorLightEntity);
      } else if (mDnsName.contains('shelly1-C45BBE78005D')) {
        final ShellyRelaySwitchEntity shellyRelaySwitchEntity =
            ShellyRelaySwitchEntity(
          uniqueId: CoreUniqueId(),
          vendorUniqueId: VendorUniqueId.fromUniqueString(mDnsName),
          defaultName: DeviceDefaultName(mDnsName),
          deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
          senderDeviceOs: DeviceSenderDeviceOs('Shelly'),
          senderDeviceModel: DeviceSenderDeviceModel('d1'),
          senderId: DeviceSenderId(),
          compUuid: DeviceCompUuid('34asdfrsd23gggg'),
          stateMassage: DeviceStateMassage('Hello World'),
          powerConsumption: DevicePowerConsumption('0'),
          devicePort: DevicePort(port),
          hostName: mDnsName.toLowerCase(),
          deviceMdnsName: DeviceMdnsName(mDnsName),
          lastKnownIp: DeviceLastKnownIp(ip),
          switchState: GenericSwitchSwitchState(false.toString()),
        );
        deviceEntityList.add(shellyRelaySwitchEntity);
      } else {
        logger.i('Shelly device types is not supported');
      }
    } catch (e) {
      logger.e('Error setting shelly\n$e');
    }

    return deviceEntityList;
  }
}
