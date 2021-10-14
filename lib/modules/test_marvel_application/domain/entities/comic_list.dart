import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/comic_summary.dart';

class ComicList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ComicSummary> items;

  ComicList({this.available, this.returned, this.collectionURI, this.items});
}
