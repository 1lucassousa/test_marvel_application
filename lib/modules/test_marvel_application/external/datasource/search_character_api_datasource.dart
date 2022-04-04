import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/error/error.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/datasource/datasource.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_content_character_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/util/key.dart';

class SearchCharacterApiDatasource implements CharacterDatasource {
  final Dio dio;

  SearchCharacterApiDatasource(this.dio);

  @override
  Future<ContentCharacter> searchCharacter(String name) async {
    final time = int.parse(DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().year.toString());

    var data = utf8.encode(time.toString() + privateKey + publicKey);

    final hash = md5.convert(data);

    var url;

    if (name.isEmpty) {
      url =
          "https://gateway.marvel.com/v1/public/characters?ts=$time&apikey=$publicKey&hash=$hash&limit=100&offset=${CharacterPageController.offset}";
    } else {
      url =
          "https://gateway.marvel.com/v1/public/characters?ts=$time&apikey=$publicKey&hash=$hash&limit=100&offset=${CharacterPageController.offset}&nameStartsWith=$name";
    }

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = ResultContentCharacterModel.fromMap(response.data);
      return result;
    } else {
      throw DatasourceError();
    }
  }
}
