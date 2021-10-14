import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/comic_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_comic_summary_model.dart';

class ResultComicListModel extends ComicList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResultComicSummaryModel> items;

  ResultComicListModel(
      {this.available, this.returned, this.collectionURI, this.items});

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'returned': returned,
      'collectionURI': collectionURI,
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultComicListModel.fromMap(Map<String, dynamic> map) {
    return ResultComicListModel(
      available: map['available'],
      returned: map['returned'],
      collectionURI: map['collectionURI'],
      items: List<ResultComicSummaryModel>.from(
          map['items']?.map((x) => ResultComicSummaryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultComicListModel.fromJson(String source) =>
      ResultComicListModel.fromMap(json.decode(source));
}
