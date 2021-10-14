import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/datasource/datasource.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/repository/search_character_repository.dart';

class CharacterDatasourceMock extends Mock implements CharacterDatasource {}

main() {

  final datasource = CharacterDatasourceMock();
  final repository = SearchCharacterRepositoryImpl(datasource);

  test("Must return a ContentCharacter", () async {

    when(datasource.searchCharacter(any)).thenAnswer((_) async => ContentCharacter());

    final result =  await repository.searchCharacter("Hulk");

    expect(result | null, isA<ContentCharacter>());

  });

  test("Must return a DatasourceError when datasource will failure", () async {

    when(datasource.searchCharacter(any)).thenThrow(DatasourceError());

    final result =  await repository.searchCharacter("Hulk"); 

    expect(result.fold(id, id), isA<DatasourceError>());

  });

}