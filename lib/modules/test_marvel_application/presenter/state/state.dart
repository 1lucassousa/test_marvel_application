import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';

abstract class State {}

class CharacterSuccess implements State {
  final ContentCharacter contentCharacter;

  CharacterSuccess(this.contentCharacter);
}

class Error implements State {
  final DatasourceError datasourceError;

  Error(this.datasourceError);
}
