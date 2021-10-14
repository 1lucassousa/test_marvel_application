import 'package:test_marvel_application/modules/test_marvel_application/domain/entities/character.dart';

class ContentCharacter {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> results;

  ContentCharacter(
      {this.offset, this.limit, this.total, this.count, this.results});
}
