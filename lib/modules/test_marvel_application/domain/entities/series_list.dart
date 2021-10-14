import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/series_summary.dart';

class SeriesList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<SeriesSummary> items;

  SeriesList({this.available, this.returned, this.collectionURI, this.items});
}
