import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/url.dart';

class ResultUrlModel extends Url {
  final String type;
  final String url;

  ResultUrlModel({this.type, this.url});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'url': url,
    };
  }

  factory ResultUrlModel.fromMap(Map<String, dynamic> map) {
    return ResultUrlModel(
      type: map['type'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultUrlModel.fromJson(String source) =>
      ResultUrlModel.fromMap(json.decode(source));
}
