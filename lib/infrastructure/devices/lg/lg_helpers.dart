import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_smart_tv/generic_smart_tv_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/lg/lg_webos_tv/lg_webos_tv_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';

class LgHelpers {
  static List<DeviceEntityAbstract> addDiscoverdDevice({
    required String mDnsName,
    required String ip,
    required String port,
  }) {
    final LgWebosTvEntity lgDE = LgWebosTvEntity(
      uniqueId: CoreUniqueId(),
      vendorUniqueId: VendorUniqueId.fromUniqueString(mDnsName),
      defaultName: DeviceDefaultName('LG'),
      deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
      senderDeviceOs: DeviceSenderDeviceOs('WebOs'),
      senderDeviceModel: DeviceSenderDeviceModel('UP7550PVG'),
      senderId: DeviceSenderId(),
      compUuid: DeviceCompUuid('34asdfrsd23gggg'),
      deviceMdnsName: DeviceMdnsName(mDnsName),
      lastKnownIp: DeviceLastKnownIp(ip),
      stateMassage: DeviceStateMassage('Hello World'),
      powerConsumption: DevicePowerConsumption('0'),
      lgPort: LgPort(port),
      smartTvSwitchState: GenericSmartTvSwitchState(
        DeviceActions.actionNotSupported.toString(),
      ),
    );

    return [lgDE];
  }
}
