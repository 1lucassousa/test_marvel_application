import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';

abstract class CharacterDatasource {
  Future<ContentCharacter> searchCharacter(String name);
}
