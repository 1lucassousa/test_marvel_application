import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/event_summary.dart';

class EventList {
  final int available;
  final int returned;
  final String collectionURI;
  final List<EventSummary> items;

  EventList({this.available, this.returned, this.collectionURI, this.items});
}
