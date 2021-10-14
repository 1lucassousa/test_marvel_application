import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/event_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_event_summary.dart';

class ResultEventListModel extends EventList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResultEventSummaryModel> items;

  ResultEventListModel(
      {this.available, this.returned, this.collectionURI, this.items});

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'returned': returned,
      'collectionURI': collectionURI,
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultEventListModel.fromMap(Map<String, dynamic> map) {
    return ResultEventListModel(
      available: map['available'],
      returned: map['returned'],
      collectionURI: map['collectionURI'],
      items: List<ResultEventSummaryModel>.from(
          map['items']?.map((x) => ResultEventSummaryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultEventListModel.fromJson(String source) =>
      ResultEventListModel.fromMap(json.decode(source));
}
