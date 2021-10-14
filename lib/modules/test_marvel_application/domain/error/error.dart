import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/error.dart';

abstract class Failure implements Exception {}

class InvalidError implements Failure {}

class DatasourceError implements Failure {
  final Error error;

  DatasourceError([this.error]);
}
