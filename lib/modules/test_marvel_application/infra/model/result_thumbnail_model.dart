import 'dart:convert';

import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/thumbnail.dart';

class ResultThumbnailModel extends Thumbnail {
  final String path;
  final String extension;

  ResultThumbnailModel({this.path, this.extension});

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'extension': extension,
    };
  }

  factory ResultThumbnailModel.fromMap(Map<String, dynamic> map) {
    return ResultThumbnailModel(
      path: map['path'],
      extension: map['extension'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultThumbnailModel.fromJson(String source) =>
      ResultThumbnailModel.fromMap(json.decode(source));
}
