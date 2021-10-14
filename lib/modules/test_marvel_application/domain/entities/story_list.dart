import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/story_summary.dart';

class StoryList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<StorySummary> items;

  StoryList({this.available, this.returned, this.collectionURI, this.items});
}
