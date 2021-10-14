import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_marvel_application/modules/test_marvel_application/external/datasource/search_character_api_datasource.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = Dio();

  final datasource = SearchCharacterApiDatasource(dio);
  
  test("Must return a ContentCharacter when request success complete", () async {

    // when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(resultResponse), statusCode: 200, requestOptions: RequestOptions(path: '')));

    final future = datasource.searchCharacter("Iron");

    expect(future, completes);

  });
}