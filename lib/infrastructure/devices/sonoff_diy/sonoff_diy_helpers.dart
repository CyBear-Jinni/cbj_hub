import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_diy/sonoff__diy_wall_switch/sonoff_diy_mod_wall_switch_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbenum.dart';
import 'package:cbj_hub/utils.dart';

class SonoffDiyHelpers {
  static Future<List<DeviceEntityAbstract>> addDiscoverdDevice({
    required String mDnsName,
    required String? port,
    required String ip,
  }) async {
    final List<DeviceEntityAbstract> deviceEntityList = [];

    try {
      if (mDnsName.contains('sonoffDiy1-C45BBE78005D')) {
        final SonoffDiyRelaySwitchEntity sonoffDiyRelaySwitchEntity =
            SonoffDiyRelaySwitchEntity(
          uniqueId: CoreUniqueId(),
          vendorUniqueId: VendorUniqueId.fromUniqueString(mDnsName),
          defaultName: DeviceDefaultName(mDnsName),
          deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
          senderDeviceOs: DeviceSenderDeviceOs('SonoffDiy'),
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
        deviceEntityList.add(sonoffDiyRelaySwitchEntity);
      } else {
        logger.i('SonoffDiy device types is not supported');
      }
    } catch (e) {
      logger.e('Error setting SonoffDiy\n$e');
    }

    return deviceEntityList;
  }
}
