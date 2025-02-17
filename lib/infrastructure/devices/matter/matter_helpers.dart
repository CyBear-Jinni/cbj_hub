import 'dart:collection';

import 'package:cbj_hub/infrastructure/devices/matter/matter_entities/matter_light_entity.dart';
import 'package:cbj_integrations_controller/integrations_controller.dart';

class MatterHelpers {
  static Future<HashMap<String, DeviceEntityBase>> addDiscoveredDevice(
    DeviceEntityBase entity,
  ) async {
    final String entityCbjUniqueId = entity.devicesMacAddress.getOrCrash() ??
        entity.deviceMdns.getOrCrash()!;
    String name;
    final String? deviceMdns = entity.deviceMdns.getOrCrash();
    final String? srvTarget = entity.srvTarget.getOrCrash();
    if (deviceMdns != null && deviceMdns.contains('-')) {
      name = deviceMdns.split('-').first;
    } else if (srvTarget != null) {
      name = srvTarget;
    } else {
      name = entity.cbjEntityName.getOrCrash() ?? '';
    }

    final MatterLightEntity matterDE = MatterLightEntity(
      uniqueId: entity.uniqueId,
      entityUniqueId: EntityUniqueId(deviceMdns),
      cbjEntityName: CbjEntityName(value: name),
      entityOriginalName: entity.entityOriginalName,
      deviceOriginalName: entity.deviceOriginalName,
      entityStateGRPC: EntityState(EntityStateGRPC.ack),
      senderDeviceOs: entity.senderDeviceOs,
      deviceVendor: entity.deviceVendor,
      deviceNetworkLastUpdate: entity.deviceNetworkLastUpdate,
      senderDeviceModel: entity.senderDeviceModel,
      senderId: entity.senderId,
      compUuid: entity.compUuid,
      deviceMdns: entity.deviceMdns,
      srvResourceRecord: entity.srvResourceRecord,
      srvTarget: entity.srvTarget,
      ptrResourceRecord: entity.ptrResourceRecord,
      mdnsServiceType: entity.mdnsServiceType,
      deviceLastKnownIp: entity.deviceLastKnownIp,
      stateMassage: entity.stateMassage,
      powerConsumption: entity.powerConsumption,
      devicePort: entity.devicePort,
      deviceUniqueId: entity.deviceUniqueId,
      deviceHostName: entity.deviceHostName,
      devicesMacAddress: entity.devicesMacAddress,
      entityKey: entity.entityKey,
      requestTimeStamp: entity.requestTimeStamp,
      lastResponseFromDeviceTimeStamp: entity.lastResponseFromDeviceTimeStamp,
      entitiyCbjUniqueId: CoreUniqueId.fromUniqueString(entityCbjUniqueId),
      lightSwitchState:
          GenericDimmableLightSwitchState(EntityActions.undefined.toString()),
      lightBrightness: GenericDimmableLightBrightness('100'),
    );

    return HashMap()
      ..addEntries([
        MapEntry(entityCbjUniqueId, matterDE),
      ]);
  }
}
