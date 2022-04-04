import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_comic_list_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_event_list_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_series_list_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_story_list_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_thumbnail_model.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_url_model.dart';

class ResultCharacterModel extends Character {
  final int id;
  final String name;
  final String description;
  final ResultThumbnailModel thumbnail;
  final ResultComicListModel comics;
  final ResultStoryListModel stories;
  final ResultEventListModel events;
  final ResultSeriesListModel series;
  final List<ResultUrlModel> urls;

  ResultCharacterModel(
      {this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.comics,
      this.stories,
      this.events,
      this.series,
      this.urls});

  get imagePath {
    return thumbnail.path + '.' + thumbnail.extension;
  }

  get characterName {
    var list = name.split("(");
    return list.first;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail.toMap(),
      'comics': comics.toMap(),
      'stories': stories.toMap(),
      'events': events.toMap(),
      'series': series.toMap(),
      'urls': urls?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultCharacterModel.fromMap(Map<String, dynamic> map) {
    return ResultCharacterModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      thumbnail: ResultThumbnailModel.fromMap(map['thumbnail']),
      comics: ResultComicListModel.fromMap(map['comics']),
      stories: ResultStoryListModel.fromMap(map['stories']),
      events: ResultEventListModel.fromMap(map['events']),
      series: ResultSeriesListModel.fromMap(map['series']),
      urls: List<ResultUrlModel>.from(
          map['urls']?.map((x) => ResultUrlModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultCharacterModel.fromJson(String source) =>
      ResultCharacterModel.fromMap(json.decode(source));
}
