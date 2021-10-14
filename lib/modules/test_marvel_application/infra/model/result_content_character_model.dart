import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/content_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_character_model.dart';

class ResultContentCharacterModel extends ContentCharacter {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<ResultCharacterModel> results;

  ResultContentCharacterModel(
      {this.offset, this.limit, this.total, this.count, this.results});

  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'limit': limit,
      'total': total,
      'count': count,
      'results': results?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultContentCharacterModel.fromMap(Map<String, dynamic> map) {
    print(map['data']['total']);
    return ResultContentCharacterModel(
      offset: map['data']['offset'],
      limit: map['data']['limit'],
      total: map['data']['total'],
      count: map['data']['count'],
      results: List<ResultCharacterModel>.from(
          map['data']['results']?.map((x) => ResultCharacterModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultContentCharacterModel.fromJson(String source) =>
      ResultContentCharacterModel.fromMap(json.decode(source));
}
