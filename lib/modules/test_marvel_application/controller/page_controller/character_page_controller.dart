import 'package:test_marvel_application/modules/test_marvel_application/controller/character_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart'
    as state;

class CharacterPageController {
  static int offset;
  static int page = 0;
  static bool isList = true;

  static initializeContentCharacter(request) {
    if (request is state.CharacterSuccess) {
      CharacterController.initializeContentCharacter(
          (request).contentCharacter);
      return state.CharacterSuccess;
    } else {
      return (request).datasourceError;
    }
  }

  static clear() {
    CharacterController.clearList();
    initializeOffset();
  }

  static addCharactersToList(request) {
    if (request is state.CharacterSuccess) {
      CharacterController.addCharactersToList(
          (request).contentCharacter.results);

      return state.CharacterSuccess;
    } else {
      return (request).datasourceError;
    }
  }

  static totalPages() {
    return (CharacterController.contentCharacterModel.total / 100).round();
  }

  static getIsList() {
    return isList;
  }

  static setIsList(value) {
    isList = value;
  }

  static initializeOffset() {
    offset = 0;
  }

  static pagination() {
    offset += 100;
    page++;
  }
}
