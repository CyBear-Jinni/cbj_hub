import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:dartz/dartz.dart';

Either<CoreFailure<String>, String> validateMatterIdNotEmpty(String input) {
  return right(input);
}

Either<CoreFailure<String>, String> validateMatterPortNotEmpty(String input) {
  return right(input);
}
