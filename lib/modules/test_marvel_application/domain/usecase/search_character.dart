import 'package:dartz/dartz.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/repository/character_repository.dart';

abstract class SearchCharacter {
  Future<Either<Failure, ContentCharacter>> call(String name);
}

class SearchCharacterImpl implements SearchCharacter {
  final CharacterRepository repository;

  SearchCharacterImpl(this.repository);

  @override
  Future<Either<Failure, ContentCharacter>> call(String name) async {
    if (name == null) {
      return Left(InvalidError());
    }

    return repository.searchCharacter(name);
  }
}
