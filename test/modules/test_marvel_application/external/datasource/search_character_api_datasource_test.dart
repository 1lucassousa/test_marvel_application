import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/external/datasource/search_character_api_datasource.dart';
import 'package:test_marvel_application/modules/test_marvel_application/util/response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = SearchCharacterApiDatasource(dio);

  test("Must return a ContentCharacter when request success complete",
      () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: jsonDecode(searchCharacterResponseResult), statusCode: 200));

    final future = datasource.searchCharacter("Steve");

    expect(future, completes);
  });

  test('Deve retornar um DatasourceError se o codigo nao for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 404));

    final future = datasource.searchCharacter("Steve");

    expect(future, throwsA(isA<DatasourceError>()));
  });
}
