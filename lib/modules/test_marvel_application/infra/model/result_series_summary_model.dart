import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/series_summary.dart';

class ResultSeriesSummaryModel extends SeriesSummary {
  final String resourceURI;
  final String name;

  ResultSeriesSummaryModel({this.resourceURI, this.name});

  Map<String, dynamic> toMap() {
    return {
      'resourceURI': resourceURI,
      'name': name,
    };
  }

  factory ResultSeriesSummaryModel.fromMap(Map<String, dynamic> map) {
    return ResultSeriesSummaryModel(
      resourceURI: map['resourceURI'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSeriesSummaryModel.fromJson(String source) =>
      ResultSeriesSummaryModel.fromMap(json.decode(source));
}
