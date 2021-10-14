import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_content_character_model.dart';

class CharacterController {
  static ResultContentCharacterModel contentCharacterModel;

  static initializeContentCharacter(data) {
    contentCharacterModel = data;
  }

  static addCharactersToList(data) {
    contentCharacterModel.results.addAll(data);
  }
}
