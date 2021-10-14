import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/story_summary.dart';

class ResultStorySummaryModel extends StorySummary {
  final String resourceURI;
  final String name;
  final String type;

  ResultStorySummaryModel({this.resourceURI, this.name, this.type});

  Map<String, dynamic> toMap() {
    return {
      'resourceURI': resourceURI,
      'name': name,
      'type': type,
    };
  }

  factory ResultStorySummaryModel.fromMap(Map<String, dynamic> map) {
    return ResultStorySummaryModel(
      resourceURI: map['resourceURI'],
      name: map['name'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultStorySummaryModel.fromJson(String source) =>
      ResultStorySummaryModel.fromMap(json.decode(source));
}
