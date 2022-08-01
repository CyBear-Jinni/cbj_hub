import 'dart:io';

abstract class ShellyApiDeviceAbstract {
  ShellyApiDeviceAbstract({
    required this.lastKnownIp,
    required this.mDnsName,
    required this.hostName,
    this.name,
  }) {
    url = 'http://$lastKnownIp';
  }

  String lastKnownIp;
  String mDnsName;
  String hostName;
  String? name;
  late String url;

  Future<String> getStatus() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/status'));
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }
}
