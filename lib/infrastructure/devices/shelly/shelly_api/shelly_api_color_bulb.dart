import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/shelly/shelly_api/shelly_api_device_abstract.dart';

class ShellyApiColorBulb extends ShellyApiDeviceAbstract {
  ShellyApiColorBulb({
    required super.lastKnownIp,
    required super.mDnsName,
    required super.hostName,
  });

  Future<String> turnOn() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=on'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> turnOff() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=off'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> changeModeToWhite() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/settings/?mode=white'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> changeModeToColor() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/settings/?mode=color'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  /// Changing brightness alone called gain and it is 0-100.
  /// I think works only on color mode
  Future<String> changeBrightnessColorGain(String brightness) async {
    final HttpClientRequest httpClientRequest = await HttpClient()
        .getUrl(Uri.parse('$url/color/0?turn=on&gain=$brightness'));
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }

  /// Change temperature and brightness, I think will also change to white mode
  Future<String> changeTemperatureAndBrightness({
    required String temperature,
    required String brightness,
  }) async {
    final HttpClientRequest httpClientRequest = await HttpClient().getUrl(
      Uri.parse(
        '$url/color/0?turn=on&temp=$temperature&brightness=$brightness',
      ),
    );
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }

  //

  /// Change color of the bulb, I think will also change to color mode
  Future<String> changeColor({
    required String red,
    required String green,
    required String blue,
    String white = "0",
  }) async {
    final HttpClientRequest httpClientRequest = await HttpClient().getUrl(
      Uri.parse(
        '$url/color/0?turn=on&red=$red&green=$green&blue=$blue&white=$white',
      ),
    );
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }
}
