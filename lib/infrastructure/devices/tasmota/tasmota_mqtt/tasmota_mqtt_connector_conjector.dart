import 'dart:async';

import 'package:cbj_hub/domain/generic_devices/abstract_device/core_failures.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/device_entity_abstract.dart';
import 'package:cbj_hub/domain/generic_devices/abstract_device/value_objects_core.dart';
import 'package:cbj_hub/domain/generic_devices/generic_light_device/generic_light_value_objects.dart';
import 'package:cbj_hub/domain/mqtt_server/i_mqtt_server_repository.dart';
import 'package:cbj_hub/infrastructure/devices/companies_connector_conjector.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_device_value_objects.dart';
import 'package:cbj_hub/infrastructure/devices/tasmota/tasmota_mqtt/tasmota_mqtt_led/tasmota_mqtt_led_entity.dart';
import 'package:cbj_hub/infrastructure/gen/cbj_hub_server/protoc_as_dart/cbj_hub_server.pbgrpc.dart';
import 'package:cbj_hub/infrastructure/generic_devices/abstract_device/abstract_company_connector_conjector.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:network_tools/network_tools.dart';

@singleton
class TasmotaMqttConnectorConjector
    implements AbstractCompanyConnectorConjector {
  TasmotaMqttConnectorConjector() {
    discoverNewDevices();
  }

  Future<void> addNewDeviceByHostInfo({
    required ActiveHost activeHost,
    required String hostName,
  }) async {
    String tempMqttTopic = hostName.replaceAll('-', '_');
    if (tempMqttTopic.lastIndexOf('_') != -1) {
      tempMqttTopic =
          tempMqttTopic.substring(0, tempMqttTopic.lastIndexOf('_'));
    }
    final String tasmotaMqttTopic = tempMqttTopic;

    /// Make all tasmotaMqtt devices repost themselves under topic discovery
    /// in the MQTT broker
    getIt<IMqttServerRepository>()
        .publishMessage('cmnd/$tasmotaMqttTopic/SetOption19', '0');
  }

  static Map<String, DeviceEntityAbstract> companyDevices = {};

  static Future<void> discoverNewDevices() async {
    getIt<IMqttServerRepository>()
        .streamOfChosenSubscription('tasmota/discovery/+/config')
        .listen((mqttPublishMessage) async {
      final String messageTopic = mqttPublishMessage[0].topic;

      final List<String> topicsSplitted = messageTopic.split('/');

      final String deviceId = topicsSplitted[2];

      bool deviceExist = false;
      for (DeviceEntityAbstract savedDevice in companyDevices.values) {
        savedDevice = savedDevice as TasmotaMqttLedEntity;

        if (deviceId == savedDevice.vendorUniqueId.getOrCrash()) {
          deviceExist = true;
          break;
        }
      }
      if (deviceExist) {
        return;
      }

      final DeviceEntityAbstract? addDevice = await mqttToDevice(
        MapEntry(messageTopic, mqttPublishMessage[0].payload),
      );

      if (addDevice == null) {
        return;
      }

      final DeviceEntityAbstract deviceToAdd =
          CompaniesConnectorConjector.addDiscoverdDeviceToHub(addDevice);

      final MapEntry<String, DeviceEntityAbstract> deviceAsEntry =
          MapEntry(deviceToAdd.uniqueId.getOrCrash(), deviceToAdd);

      companyDevices.addEntries([deviceAsEntry]);
      logger.v('Adding Tasmota mqtt device');
    });
  }

  static Future<DeviceEntityAbstract?> mqttToDevice(
    MapEntry<String, dynamic> deviceChangeFromMqtt,
  ) async {
    final List<String> topicsSplitted = deviceChangeFromMqtt.key.split('/');
    if (topicsSplitted.length < 3 || topicsSplitted[3] != 'config') {
      return null;
    }

    final String pt = MqttPublishPayload.bytesToStringAsString(
      (deviceChangeFromMqtt.value as MqttPublishMessage).payload.message,
    ).replaceAll('\n', '');

    /// mac = Mac address of the device
    final String? mac = getValueFromMqttResult(pt, 'mac');

    /// Check if this is result full of info and not just response for action
    if (mac == null) {
      return null;
    }

    /// t = mqtt topic of device
    final String deviceTopic = getValueFromMqttResult(pt, '"t"')!;

    /// state = List of all the device supported states
    final String supportedStatesOfDevice = getValueFromMqttResult(pt, 'state')!;

    /// dn = Device Name (Tasmotac)
    final String name = getValueFromMqttResult(pt, 'dn')!;

    const DeviceActions deviceActions = DeviceActions.actionNotSupported;

    if (supportedStatesOfDevice.contains('ON') &&
        supportedStatesOfDevice.contains('OFF')) {
      return TasmotaMqttLedEntity(
        uniqueId: CoreUniqueId(),
        vendorUniqueId: VendorUniqueId.fromUniqueString(mac),
        defaultName: DeviceDefaultName(name),
        deviceStateGRPC: DeviceState(DeviceStateGRPC.ack.toString()),
        senderDeviceOs: DeviceSenderDeviceOs('TasmotaMqtt'),
        senderDeviceModel: DeviceSenderDeviceModel('LED'),
        senderId: DeviceSenderId(),
        compUuid: DeviceCompUuid(mac),
        stateMassage: DeviceStateMassage('Hello World'),
        powerConsumption: DevicePowerConsumption('0'),
        lightSwitchState: GenericLightSwitchState(deviceActions.toString()),
        tasmotaMqttDeviceTopicName: TasmotaMqttDeviceTopicName(deviceTopic),
      );
    }
  }

  static String? getValueFromMqttResult(String result, String valueName) {
    String value;
    try {
      value = result.substring(result.indexOf(valueName));
      value = value.substring(value.indexOf(':') + 2);
      value = value.substring(0, value.indexOf(':') - 1);
      if (value.contains(']')) {
        value = value.substring(0, value.indexOf(']'));
      } else {
        value = value.substring(0, value.indexOf(',') - 1);
      }
    } catch (e) {
      return null;
    }
    return value;
  }

  Future<Either<CoreFailure, Unit>> create(DeviceEntityAbstract tasmotaMqtt) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<Either<CoreFailure, Unit>> delete(DeviceEntityAbstract tasmotaMqtt) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> initiateHubConnection() {
    // TODO: implement initiateHubConnection
    throw UnimplementedError();
  }

  Future<void> manageHubRequestsForDevice(
    DeviceEntityAbstract tasmotaMqttDE,
  ) async {
    final DeviceEntityAbstract? device =
        companyDevices[tasmotaMqttDE.getDeviceId()];

    if (device is TasmotaMqttLedEntity) {
      device.executeDeviceAction(newEntity: tasmotaMqttDE);
    } else {
      logger.w('TasmotaMqtt device type does not exist');
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
