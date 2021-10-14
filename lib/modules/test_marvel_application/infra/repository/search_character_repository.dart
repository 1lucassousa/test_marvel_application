import 'package:dartz/dartz.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/repository/character_repository.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/datasource/datasource.dart';

class SearchCharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource datasource;

  SearchCharacterRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, ContentCharacter>> searchCharacter(String name) async {
    try {
      final result = await datasource.searchCharacter(name);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError(e));
    }
  }
}
