import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/comic_summary.dart';

class ResultComicSummaryModel extends ComicSummary {
  final String resourceURI;
  final String name;

  ResultComicSummaryModel({this.resourceURI, this.name});

  Map<String, dynamic> toMap() {
    return {
      'resourceURI': resourceURI,
      'name': name,
    };
  }

  factory ResultComicSummaryModel.fromMap(Map<String, dynamic> map) {
    return ResultComicSummaryModel(
      resourceURI: map['resourceURI'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultComicSummaryModel.fromJson(String source) =>
      ResultComicSummaryModel.fromMap(json.decode(source));
}
