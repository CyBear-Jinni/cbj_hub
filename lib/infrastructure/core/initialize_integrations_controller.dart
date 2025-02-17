import 'dart:io';

import 'package:cbj_hub/infrastructure/core/injection.dart';
import 'package:cbj_hub/utils.dart';
import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:hive/hive.dart';

Future initializeIntegrationsController({
  required String? projectRootDirectoryPath,
  required String env,
}) async {
  configureInjection(env);

  try {
    if (projectRootDirectoryPath != null) {
      await SharedVariables().asyncConstructor(projectRootDirectoryPath);
    } else {
      await SharedVariables().asyncConstructor(Directory.current.path);
    }
  } catch (error) {
    logger.e('Path/argument 1 is not specified\n$error');
  }

  //  Setting device model and checking if configuration for this model exist
  setInstanceForDartNative();
  await DevicePinListManager().setPhysicalDeviceType();

  Hive.init(await dbPath());
}

Future<String> dbPath() async {
  String? localDbPath =
      await SystemCommandsBaseClassD.instance.getLocalDbPath();

  if (localDbPath[localDbPath.length - 1] == '/') {
    localDbPath = localDbPath.substring(0, localDbPath.length - 1);
  }

  localDbPath += '/hive';

  logger.i('Hive db location\n$localDbPath');
  return localDbPath;
}
