import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/philips_hue/philips_hue_e26/philips_hue_e26_entity.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class PhilipsHueConnectorConjector
    implements AbstractCompanyConnectorConjector {
  PhilipsHueConnectorConjector() {
    _discoverNewDevices();
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  Future<void> _discoverNewDevices() async {}

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract philipsHue) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract philipsHue) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract philipsHueDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[philipsHueDE.getDeviceId()];

    if (device is PhilipsHueE26Entity) {
      device.executeDeviceAction(newEntity: philipsHueDE);
    } else {
      logger.w('PhilipsHue device type does not exist');
    }
  }

  Future<Either<CoreFailure, Unit>> updateDatabase({
    required String pathOfField,
    required Map<String, dynamic> fieldsToUpdate,
    String? forceUpdateLocation,
  }) async {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
