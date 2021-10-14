import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/error.dart';

class ResultErrorModel extends Error {
  final int code;
  final String status;

  ResultErrorModel(this.code, this.status);

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'status': status,
    };
  }

  factory ResultErrorModel.fromMap(Map<String, dynamic> map) {
    return ResultErrorModel(
      map['code'],
      map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultErrorModel.fromJson(String source) =>
      ResultErrorModel.fromMap(json.decode(source));
}
