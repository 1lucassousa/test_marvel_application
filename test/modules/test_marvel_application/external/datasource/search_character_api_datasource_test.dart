import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_marvel_application/modules/test_marvel_application/external/datasource/search_character_api_datasource.dart';

main() {
  final dio = Dio();

  final datasource = SearchCharacterApiDatasource(dio);

  test("Must return a ContentCharacter when request success complete",
      () async {
    final future = datasource.searchCharacter("Iron");

    expect(future, completes);
  });
}
