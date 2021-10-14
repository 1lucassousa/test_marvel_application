import 'package:dartz/dartz.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';

abstract class CharacterRepository {
  Future<Either<Failure, ContentCharacter>> searchCharacter(String name);
}
