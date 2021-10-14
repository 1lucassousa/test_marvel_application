import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/comic_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/event_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/series_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/story_list.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/thumbnail.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/url.dart';

class Character {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;
  final ComicList comics;
  final StoryList stories;
  final EventList events;
  final SeriesList series;
  final List<Url> urls;

  Character(
      {this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.comics,
      this.stories,
      this.events,
      this.series,
      this.urls});
}
