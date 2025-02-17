import 'package:cbj_integrations_controller/integrations_controller.dart';

class NodeRedMatterControllerNode extends NodeRedNodeAbstract {
  NodeRedMatterControllerNode()
      : super(
          type: 'mattercontroller',
        );

  @override
  String toString() {
    return '''
    {
    "id": "$id",
    "type": "$type",
    }
    ''';
  }
}
