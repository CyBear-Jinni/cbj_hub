import 'dart:async';

import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:dartz/dartz.dart';

class MatterLightEntity extends GenericDimmableLightDE {
  MatterLightEntity({
    required super.uniqueId,
    required super.entityUniqueId,
    required super.cbjEntityName,
    required super.entityOriginalName,
    required super.deviceOriginalName,
    required super.deviceVendor,
    required super.deviceNetworkLastUpdate,
    required super.stateMassage,
    required super.senderDeviceOs,
    required super.senderDeviceModel,
    required super.senderId,
    required super.compUuid,
    required super.entityStateGRPC,
    required super.powerConsumption,
    required super.deviceUniqueId,
    required super.devicePort,
    required super.deviceLastKnownIp,
    required super.deviceHostName,
    required super.deviceMdns,
    required super.srvResourceRecord,
    required super.srvTarget,
    required super.ptrResourceRecord,
    required super.mdnsServiceType,
    required super.devicesMacAddress,
    required super.entityKey,
    required super.requestTimeStamp,
    required super.lastResponseFromDeviceTimeStamp,
    required super.entitiyCbjUniqueId,
    required super.lightSwitchState,
    required super.lightBrightness,
  }) : super(
          cbjDeviceVendor: CbjDeviceVendor(VendorsAndServices.matter),
        );

  factory MatterLightEntity.fromGeneric(GenericDimmableLightDE entity) {
    return MatterLightEntity(
      uniqueId: entity.uniqueId,
      entityUniqueId: entity.entityUniqueId,
      cbjEntityName: entity.cbjEntityName,
      entityOriginalName: entity.entityOriginalName,
      deviceOriginalName: entity.deviceOriginalName,
      deviceVendor: entity.deviceVendor,
      deviceNetworkLastUpdate: entity.deviceNetworkLastUpdate,
      stateMassage: entity.stateMassage,
      senderDeviceOs: entity.senderDeviceOs,
      senderDeviceModel: entity.senderDeviceModel,
      senderId: entity.senderId,
      compUuid: entity.compUuid,
      entityStateGRPC: entity.entityStateGRPC,
      powerConsumption: entity.powerConsumption,
      deviceUniqueId: entity.deviceUniqueId,
      devicePort: entity.devicePort,
      deviceLastKnownIp: entity.deviceLastKnownIp,
      deviceHostName: entity.deviceHostName,
      deviceMdns: entity.deviceMdns,
      srvResourceRecord: entity.srvResourceRecord,
      srvTarget: entity.srvTarget,
      ptrResourceRecord: entity.ptrResourceRecord,
      mdnsServiceType: entity.mdnsServiceType,
      devicesMacAddress: entity.devicesMacAddress,
      entityKey: entity.entityKey,
      requestTimeStamp: entity.requestTimeStamp,
      lastResponseFromDeviceTimeStamp: entity.lastResponseFromDeviceTimeStamp,
      lightSwitchState: entity.lightSwitchState,
      entitiyCbjUniqueId: entity.entitiyCbjUniqueId,
      lightBrightness: entity.lightBrightness,
    );
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    // lightSwitchState =
    //     GenericDimmableLightSwitchState(EntityActions.on.toString());
    // try {
    //   final String nodeRedApiBaseTopic =
    //       IMqttServerRepository.instance.getNodeRedApiBaseTopic();
    //
    //   final String nodeRedDevicesTopic =
    //       IMqttServerRepository.instance.getNodeRedDevicesTopicTypeName();
    //   final String topic =
    //       '$nodeRedApiBaseTopic/$nodeRedDevicesTopic/${entityKey.getOrCrash()}/${EspHomeNodeRedApi.deviceStateProperty}/${EspHomeNodeRedApi.inputDeviceProperty}';
    //
    //   IMqttServerRepository.instance
    //       .publishMessage(topic, """{"state":true}""");
    // } catch (e) {
    //   return left(const CoreFailure.unexpected());
    // }
    return right(unit);
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    try {
      // final setStateBodyResponse = NodeRedRepository().
      //
      // if (setStateBodyResponse == null) {
      //   throw 'setStateBodyResponse is null';
      // }

      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // MatterHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> setBrightness(int value) async {
    try {
      // final setStateBodyResponse = NodeRedRepository().
      //
      // if (setStateBodyResponse == null) {
      //   throw 'setStateBodyResponse is null';
      // }

      return right(unit);
    } catch (e) {
      // As we are using the fast = true the response is always
      // MatterHttpException Error
      return right(unit);
      // return left(const CoreFailure.unexpected());
    }
  }
}
