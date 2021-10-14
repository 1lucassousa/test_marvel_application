import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/datasource/datasource.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_content_character_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_error_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/util/key.dart';

class SearchCharacterApiDatasource implements CharacterDatasource {
  final Dio dio;

  SearchCharacterApiDatasource(this.dio);

  @override
  Future<ContentCharacter> searchCharacter(String name) async {
    print("1");

    final time = int.parse(DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().year.toString());

    var data = utf8.encode(time.toString() + privateKey + publicKey);

    final hash = md5.convert(data);

    var url;

    print(hash);

    if (name.isEmpty) {
      url =
          "https://gateway.marvel.com/v1/public/characters?ts=$time&apikey=$publicKey&hash=$hash&limit=100&offset=${CharacterPageController.offset}";
    } else {
      url =
          "https://gateway.marvel.com/v1/public/characters?ts=$time&apikey=$publicKey&hash=$hash&limit=100&offset=${CharacterPageController.offset}&nameStartsWith=$name";
    }

    print(url);

    var response = await dio.get(
      url,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    );

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('2');
      final result = ResultContentCharacterModel.fromMap(response.data);
      print('sucesso');
      return result;
    } else {
      throw DatasourceError(ResultErrorModel.fromMap(response.data));
    }
  }
}
