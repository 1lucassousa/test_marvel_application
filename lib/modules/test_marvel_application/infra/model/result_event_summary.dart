import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/event_summary.dart';

class ResultEventSummaryModel extends EventSummary {
  final String resourceURI;
  final String name;

  ResultEventSummaryModel({this.resourceURI, this.name});

  Map<String, dynamic> toMap() {
    return {
      'resourceURI': resourceURI,
      'name': name,
    };
  }

  factory ResultEventSummaryModel.fromMap(Map<String, dynamic> map) {
    return ResultEventSummaryModel(
      resourceURI: map['resourceURI'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultEventSummaryModel.fromJson(String source) =>
      ResultEventSummaryModel.fromMap(json.decode(source));
}
