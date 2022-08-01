import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/device_type_enums.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_entity.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/esphome/esphome_api/esphome_api_client.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';

class EspHomeLightEntity extends GenericLightDE {
  EspHomeLightEntity({
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
    required GenericLightSwitchState lightSwitchState,
    required this.deviceMdnsName,
    required this.devicePort,
    this.lastKnownIp,
  }) : super(
          uniqueId: uniqueId,
          vendorUniqueId: vendorUniqueId,
          defaultName: defaultName,
          lightSwitchState: lightSwitchState,
          deviceStateGRPC: deviceStateGRPC,
          stateMassage: stateMassage,
          senderDeviceOs: senderDeviceOs,
          senderDeviceModel: senderDeviceModel,
          senderId: senderId,
          deviceVendor: DeviceVendor(VendorsAndServices.espHome.toString()),
          compUuid: compUuid,
          powerConsumption: powerConsumption,
        );

  DeviceLastKnownIp? lastKnownIp;

  DeviceMdnsName deviceMdnsName;

  DevicePort devicePort;

  @override
  Future<Either<CoreFailure, Unit>> executeDeviceAction({
    required DeviceEntityAbstract newEntity,
  }) async {
    if (newEntity is! GenericLightDE) {
      return left(
        const CoreFailure.actionExcecuter(
          failedValue: 'Not the correct type',
        ),
      );
    }

    try {
      if (newEntity.lightSwitchState!.getOrCrash() !=
              lightSwitchState!.getOrCrash() ||
          deviceStateGRPC.getOrCrash() != DeviceStateGRPC.ack.toString()) {
        final DeviceActions? actionToPreform =
            EnumHelperCbj.stringToDeviceAction(
          newEntity.lightSwitchState!.getOrCrash(),
        );

        if (actionToPreform == DeviceActions.on) {
          (await turnOnLight()).fold((l) {
            logger.e('Error turning ESPHome light on');
            throw l;
          }, (r) {
            logger.i('ESPHome light turn on success');
          });
        } else if (actionToPreform == DeviceActions.off) {
          (await turnOffLight()).fold((l) {
            logger.e('Error turning ESPHome light off');
            throw l;
          }, (r) {
            logger.i('ESPHome light turn off success');
          });
        } else {
          logger.e('actionToPreform is not set correctly ESPHome light');
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
  Future<Either<CoreFailure, Unit>> turnOnLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.on.toString());

    try {
      logger.v('Turn on ESPHome device');
      EspHomeApiClient espHomeApi;
      try {
        espHomeApi = EspHomeApiClient(
          deviceMdnsT: deviceMdnsName.getOrCrash(),
          devicePass: 'MyPassword',
        );
        //
        // EspHomeApi.listenToResponses();
      } catch (mDnsCannotBeFound) {
        espHomeApi = EspHomeApiClient(
          deviceMdnsT: lastKnownIp!.getOrCrash(),
          devicePass: 'MyPassword',
        );
        //
        // EspHomeApi.listenToResponses();
      }
      await espHomeApi.sendConnect();
      // await EspHomeApi.deviceInfoRequestToEsp();
      // await EspHomeApi.listEntitiesRequest();
      // await EspHomeApi.subscribeStatesRequest();
      await espHomeApi.switchCommandRequest(
        int.parse(vendorUniqueId.getOrCrash()),
        true,
      );
      await espHomeApi.disconnect();
      return right(unit);
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }

  @override
  Future<Either<CoreFailure, Unit>> turnOffLight() async {
    lightSwitchState = GenericLightSwitchState(DeviceActions.off.toString());

    try {
      try {
        logger.v('Turn off ESPHome device');
        EspHomeApiClient espHomeApi;
        try {
          espHomeApi = EspHomeApiClient(
            deviceMdnsT: deviceMdnsName.getOrCrash(),
            devicePass: 'MyPassword',
          );
          //
          // EspHomeApi.listenToResponses();
        } catch (mDnsCannotBeFound) {
          espHomeApi = EspHomeApiClient(
            deviceMdnsT: lastKnownIp!.getOrCrash(),
            devicePass: 'MyPassword',
          );
          //
          // EspHomeApi.listenToResponses();
        }
        await espHomeApi.sendConnect();
        // await EspHomeApi.deviceInfoRequestToEsp();
        // await EspHomeApi.listEntitiesRequest();
        // await EspHomeApi.subscribeStatesRequest();
        await espHomeApi.switchCommandRequest(
          int.parse(vendorUniqueId.getOrCrash()),
          false,
        );
        await espHomeApi.disconnect();
        return right(unit);
      } catch (exception) {
        return left(const CoreFailure.unexpected());
      }
    } catch (e) {
      return left(const CoreFailure.unexpected());
    }
  }
}
