import 'package:cbj_integrations_controller/integrations_controller.dart';

class NodeRedMatterSubscribeNode extends NodeRedVisualNodeAbstract {
  NodeRedMatterSubscribeNode({
    required this.controller,
    required this.deviceName,
    required this.cluster,
    required this.attr,
    super.name,
  }) : super(
          type: 'mattersubscribe',
        );

  final String controller;
  final String deviceName;
  final String attr;
  final int cluster;

  @override
  String toString() {
    return '''
    {
    "id": "$id",
    "type": "$type",
    "name": "$name",
    "controller": "$controller",
    "device": "17174800272800391268-1",
    "deviceName": "$deviceName",
    "cluster": "$cluster",
    "attr": "$attr",
    "simpleMode": true,
    "wires":  ${fixWiresForNodeRed()}
    }
    ''';
  }
}
