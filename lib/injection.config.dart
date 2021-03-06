// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/app_communication/i_app_communication_repository.dart' as _i5;
import 'domain/local_db/i_local_db_repository.dart' as _i7;
import 'domain/mqtt_server/i_mqtt_server_repository.dart' as _i9;
import 'domain/node_red/i_node_red_repository.dart' as _i11;
import 'domain/rooms/i_saved_rooms_repo.dart' as _i15;
import 'domain/saved_devices/i_saved_devices_repo.dart' as _i13;
import 'domain/scene/i_scene_cbj_repository.dart' as _i17;
import 'infrastructure/app_communication/app_communication_repository.dart'
    as _i6;
import 'infrastructure/devices/esphome/esphome_connector_conjector.dart' as _i3;
import 'infrastructure/devices/google/google_connector_conjector.dart' as _i4;
import 'infrastructure/devices/lifx/lifx_connector_conjector.dart' as _i19;
import 'infrastructure/devices/philips_hue/philips_hue_connector_conjector.dart'
    as _i20;
import 'infrastructure/devices/switcher/switcher_connector_conjector.dart'
    as _i21;
import 'infrastructure/devices/tasmota/tasmota_connector_conjector.dart'
    as _i22;
import 'infrastructure/devices/tuya_smart/tuya_smart_connector_conjector.dart'
    as _i23;
import 'infrastructure/devices/xiaomi_io/xiaomi_io_connector_conjector.dart'
    as _i24;
import 'infrastructure/devices/yeelight/yeelight_connector_conjector.dart'
    as _i25;
import 'infrastructure/local_db/local_db_repository.dart' as _i8;
import 'infrastructure/mqtt_server/mqtt_server_repository.dart' as _i10;
import 'infrastructure/node_red/node_red_repository.dart' as _i12;
import 'infrastructure/room/saved_rooms_repo.dart' as _i16;
import 'infrastructure/saved_devices/saved_devices_repo.dart' as _i14;
import 'infrastructure/scenes/scene_repository.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ESPHomeConnectorConjector>(_i3.ESPHomeConnectorConjector());
  gh.singleton<_i4.GoogleConnectorConjector>(_i4.GoogleConnectorConjector());
  gh.lazySingleton<_i5.IAppCommunicationRepository>(
      () => _i6.AppCommunicationRepository());
  gh.lazySingleton<_i7.ILocalDbRepository>(() => _i8.HiveRepository());
  gh.lazySingleton<_i9.IMqttServerRepository>(
      () => _i10.MqttServerRepository());
  gh.lazySingleton<_i11.INodeRedRepository>(() => _i12.NodeRedRepository());
  gh.lazySingleton<_i13.ISavedDevicesRepo>(() => _i14.SavedDevicesRepo());
  gh.lazySingleton<_i15.ISavedRoomsRepo>(() => _i16.SavedRoomsRepo());
  gh.lazySingleton<_i17.ISceneCbjRepository>(() => _i18.SceneCbjRepository());
  gh.singleton<_i19.LifxConnectorConjector>(_i19.LifxConnectorConjector());
  gh.singleton<_i20.PhilipsHueConnectorConjector>(
      _i20.PhilipsHueConnectorConjector());
  gh.singleton<_i21.SwitcherConnectorConjector>(
      _i21.SwitcherConnectorConjector());
  gh.singleton<_i22.TasmotaConnectorConjector>(
      _i22.TasmotaConnectorConjector());
  gh.singleton<_i23.TuyaSmartConnectorConjector>(
      _i23.TuyaSmartConnectorConjector());
  gh.singleton<_i24.XiaomiIoConnectorConjector>(
      _i24.XiaomiIoConnectorConjector());
  gh.singleton<_i25.YeelightConnectorConjector>(
      _i25.YeelightConnectorConjector());
  return get;
}
