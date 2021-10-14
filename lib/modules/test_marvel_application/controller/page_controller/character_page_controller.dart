import 'package:test_marvel_application/modules/test_marvel_application/controller/character_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart'
    as state;

class CharacterPageController {
  static int offset;
  static int page = 0;

  static initializeContentCharacter(request) {
    if (request is state.CharacterSuccess) {
      CharacterController.initializeContentCharacter(
          (request).contentCharacter);

      return state.CharacterSuccess;
    }
  }

  static addCharactersToList(request) {
    if (request is state.CharacterSuccess) {
      CharacterController.addCharactersToList(
          (request).contentCharacter.results);

      return state.CharacterSuccess;
    }
  }

  static totalPages() {
    return (CharacterController.contentCharacterModel.total / 100).round();
  }

  static initializeOffset() {
    print('foi?!');
    offset = 0;
  }

  static pagination() {
    offset += 100;
    page++;
  }
}
