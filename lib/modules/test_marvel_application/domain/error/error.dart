abstract class Failure implements Exception {}

class InvalidError implements Failure {}

class DatasourceError implements Failure {
  final String error;

  DatasourceError([this.error]);
}
