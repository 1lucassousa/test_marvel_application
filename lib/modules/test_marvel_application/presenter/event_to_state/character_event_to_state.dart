import 'package:test_marvel_application/modules/test_marvel_application/domain/usecase/search_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart';

class CharacterEventToState {
  final SearchCharacter usecase;

  CharacterEventToState(this.usecase);

  Future mapEventToState(String name) async {
    final result = await usecase(name);
    print("Event0");
    print(result);
    return result.fold((l) => Error(l), (r) => CharacterSuccess(r));
  }
}
