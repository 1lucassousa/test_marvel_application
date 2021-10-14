import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/series_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/model/result_series_summary_model.dart';

class ResultSeriesListModel extends SeriesList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResultSeriesSummaryModel> items;

  ResultSeriesListModel(
      {this.available, this.returned, this.collectionURI, this.items});

  Map<String, dynamic> toMap() {
    return {
      'available': available,
      'returned': returned,
      'collectionURI': collectionURI,
      'items': items?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ResultSeriesListModel.fromMap(Map<String, dynamic> map) {
    return ResultSeriesListModel(
      available: map['available'],
      returned: map['returned'],
      collectionURI: map['collectionURI'],
      items: List<ResultSeriesSummaryModel>.from(
          map['items']?.map((x) => ResultSeriesSummaryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSeriesListModel.fromJson(String source) =>
      ResultSeriesListModel.fromMap(json.decode(source));
}
