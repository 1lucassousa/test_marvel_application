import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/repository/character_repository.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/usecase/search_character.dart';

class SearchRepositoryMock extends Mock implements CharacterRepository{}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchCharacterImpl(repository);

  test("Must return a ContentCharacter", () async {

    when(repository.searchCharacter(any)).thenAnswer((_) async => Right(ContentCharacter()));

    final result = await usecase("Hulk");
    expect(result | null, isA<ContentCharacter>());
  });

  test("Must return a Failure when text is null", () async {

    when(repository.searchCharacter(any)).thenAnswer((_) async => Right(ContentCharacter()));

    final result = await usecase(null);
    expect(result.fold(id, id), isA<Failure>());
  });

}