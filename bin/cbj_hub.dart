import 'dart:io';

import 'package:cbj_hub/application/boot_up/boot_up.dart';
import 'package:cbj_hub/domain/local_db/i_local_db_repository.dart';
import 'package:cbj_hub/infrastructure/core/singleton/my_singleton.dart';
import 'package:cbj_hub/infrastructure/shared_variables.dart';
import 'package:cbj_hub/infrastructure/system_commands/device_pin_manager.dart';
import 'package:cbj_hub/injection.dart';
import 'package:cbj_hub/utils.dart';

Future<void> main(List<String> arguments) async {
  configureInjection(Env.prod);

  try {
    SharedVariables(arguments[0]);
  } catch (error) {
    logger.w('Path/argument 1 is not specified\n$error');
  }

  //  Setting device model and checking if configuration for this model exist
  await DevicePinListManager().setPhysicalDeviceType();
  // Fix for windows error reusePort
  if (Platform.isWindows) {
    await MySingleton.getLocalDbPath();
  }

  getIt<ILocalDbRepository>();
  logger.v('');

  await BootUp.setup();
}
