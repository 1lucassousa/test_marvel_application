import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/story_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_story_summary_model.dart';

class ResultStoryListModel extends StoryList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResultStorySummaryModel> items;

  ResultStoryListModel(
      {this.available, this.returned, this.collectionURI, this.items});

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'returned': returned,
      'collectionURI': collectionURI,
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultStoryListModel.fromMap(Map<String, dynamic> map) {
    return ResultStoryListModel(
      available: map['available'],
      returned: map['returned'],
      collectionURI: map['collectionURI'],
      items: List<ResultStorySummaryModel>.from(
          map['items']?.map((x) => ResultStorySummaryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultStoryListModel.fromJson(String source) =>
      ResultStoryListModel.fromMap(json.decode(source));
}
