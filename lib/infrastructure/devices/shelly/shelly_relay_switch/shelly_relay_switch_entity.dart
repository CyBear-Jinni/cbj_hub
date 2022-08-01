import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_switch_device/generic_switch_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/shelly/shelly_api/shelly_api_relay_switch.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class ShellyRelaySwitchEntity extends GenericSwitchDE {
  ShellyRelaySwitchEntity({
    required CoreUniqueId uniqueId,
    required VendorUniqueId vendorUniqueId,
    required DeviceDefaultName defaultName,
    required DeviceState deviceStateGRPC,
    required DeviceStateMassage stateMassage,
    required DeviceSenderDeviceOs senderDeviceOs,
    required DeviceSenderDeviceModel senderDeviceModel,
    required DeviceSenderId senderId,
    required DeviceCompUuid compUuid,
    required DevicePowerConsumption powerConsumption,
    required GenericSwitchSwitchState switchState,
    required this.deviceMdnsName,
    required this.devicePort,
    required this.lastKnownIp,
    required String hostName,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          switchState: switchState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.shelly.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        ) {
    shellyRelaySwitch = ShellyApiRelaySwitch(
      lastKnownIp: lastKnownIp.getOrCrash(),
      mDnsName: deviceMdnsName.getOrCrash(),
      hostName: hostName,
    );
  }

  DeviceLastKnownIp lastKnownIp;

  DeviceMdnsName deviceMdnsName;

  DevicePort devicePort;

  late ShellyApiRelaySwitch shellyRelaySwitch;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericSwitchDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.switchState!.getOrCrash() != switchState!.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.switchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnSwitch()).fold(
            (l) {
              logger.e('Error turning Shelly switch on\n$l');
              throw l;
            },
            (r) {
              logger.i('Shelly switch turn on success');
            },
          );
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffSwitch()).fold(
            (l) {
              logger.e('Error turning Shelly off\n$l');
              throw l;
            },
            (r) {
              logger.i('Shelly switch turn off success');
            },
          );
        } else {
          logger.w(
            'actionToPreform is not set correctly on Shelly Switch',
          );
        }
      }
      deviceStateGRPC = DeviceState(DeviceStateGRPC.ack.toString());
      return right(unit);
    } catch (e) {
      deviceStateGRPC = DeviceState(DeviceStateGRPC.newStateFailed.toString());
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOnSwitch() async {
    switchState = GenericSwitchSwitchState(DeviceActions.on.toString());

    try {
      logger.v('Turn on Shelly device');
      shellyRelaySwitch.turnOn();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffSwitch() async {
    switchState = GenericSwitchSwitchState(DeviceActions.off.toString());

    try {
      logger.v('Turn off Shelly device');
      await shellyRelaySwitch.turnOff();
      return right(unit);
    } catch (exception) {
      return left(const CoreFailure.unexpected());
    }
  }
}
