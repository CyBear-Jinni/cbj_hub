import 'package:cbj_hub/domain/binding/binding_cbj_entity.dart';
import 'package:cbj_hub/domain/node_red/i_node_red_repository.dart';
import 'package:cbj_hub/domain/routine/routine_cbj_entity.dart';
import 'package:cbj_hub/domain/scene/scene_cbj_entity.dart';
import 'package:cbj_hub/infrastructure/node_red/node_red_api/node_red_api.dart';
import 'package:cbj_hub/utils.dart';
import 'package:http/src/response.dart';
import 'package:injectable/injectable.dart';

/// Control Node-RED, create scenes and more
@LazySingleton(as: INodeRedRepository)
class NodeRedRepository extends INodeRedRepository {
  static NodeRedAPI nodeRedAPI = NodeRedAPI();

  /// List of all the scenes JSONs in Node-RED
  List<String> scenesList = [];

  /// List of all the routines JSONs in Node-RED
  List<String> routinesList = [];

  /// List of all the bindings JSONs in Node-RED
  List<String> bindingsList = [];

  @override
  Future<bool> createNewNodeRedScene(SceneCbjEntity sceneCbj) async {
    // TODO: Check if sceneCbj unique Id exist, if so don't try to add it again
    final Response response = await nodeRedAPI.postFlow(
      label: sceneCbj.name.getOrCrash(),
      nodes: sceneCbj.automationString.getOrCrash()!,
    );
    if (response.statusCode == 200) {
      return true;
    }
    logger.i('Response\n${response.statusCode}');
    return false;
  }

  @override
  Future<bool> createNewNodeRedRoutine(RoutineCbjEntity routineCbj) async {
    // TODO: Check if routineCbj unique Id exist, if so don't try to add it again
    final Response response = await nodeRedAPI.postFlow(
      label: routineCbj.name.getOrCrash(),
      nodes: routineCbj.automationString.getOrCrash()!,
    );
    if (response.statusCode == 200) {
      return true;
    }
    logger.i('Response\n${response.statusCode}');
    return false;
  }

  @override
  Future<bool> createNewNodeRedBinding(BindingCbjEntity bindingCbj) async {
    // TODO: Check if routineCbj unique Id exist, if so don't try to add it again
    final Response response = await nodeRedAPI.postFlow(
      label: bindingCbj.name.getOrCrash(),
      nodes: bindingCbj.automationString.getOrCrash()!,
    );
    if (response.statusCode == 200) {
      return true;
    }
    logger.i('Response\n${response.statusCode}');
    return false;
  }
}
