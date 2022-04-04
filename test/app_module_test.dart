import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_marvel_application/app_module.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/usecase/search_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_content_character_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/util/response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [Bind<Dio>((i) => dio)]);

  test('Deve recuperar um usecase sem erro', () {
    final usecase = Modular.get<SearchCharacter>();
    expect(usecase, isA<SearchCharacterImpl>());
  });

  test('Deve trazer um ResultContentCharacterModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
        data: jsonDecode(searchCharacterResponseResult), statusCode: 200));

    final usecase = Modular.get<SearchCharacter>();
    final result = await usecase('');

    expect(result | null, isA<ResultContentCharacterModel>());
  });
}
