import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_diy/sonoff__diy_wall_switch/sonoff_diy_mod_wall_switch_entity.dart';
import 'package:cbj_hub/infrastructure/devices/sonoff_diy/sonoff_diy_helpers.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class SonoffDiyConnectorConjector implements AbstractCompanyConnectorConjector {
  static const List<String> mdnsTypes = ['_ewelink._tcp'];

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  /// Add new devices to [companyDevices] if not exist
  Future<void> addNewDeviceByMdnsName({
    required String mDnsName,
    required String ip,
    required String port,
  }) async {
    for (final DeviceEntityAbstract device in companyDevices.values) {
      if (device is SonoffDiyRelaySwitchEntity) {
        if (mDnsName == device.deviceMdnsName.getOrCrash()) {
          return;
        }
      } else {
        logger.w(
            "Can't add sonoff diy device, type was not set to get device ID");
        return;
      }
    }

    final List<DeviceEntityAbstract> espDevice =
        await SonoffDiyHelpers.addDiscoverdDevice(
      mDnsName: mDnsName,
      ip: ip,
      port: port,
    );

    if (espDevice.isEmpty) {
      return;
    }

    for (final DeviceEntityAbstract entityAsDevice in espDevice) {
      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(entityAsDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
    }
    logger.v('New sonoff diy devices name:$mDnsName');
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract sonoffDiyDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[sonoffDiyDE.getDeviceId()];

    if (device is SonoffDiyRelaySwitchEntity) {
      device.executeDeviceAction(newEntity: sonoffDiyDE);
    } else {
      logger.w('Sonoff diy device type does not exist');
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

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract sonoffDiy) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract sonoffDiy) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }
}
