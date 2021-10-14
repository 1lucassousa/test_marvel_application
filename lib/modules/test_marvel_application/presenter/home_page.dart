import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/character_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/event_to_state/character_event_to_state.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart'
    as state;

class HomePage extends StatelessWidget {
  final eventToState = Modular.get<CharacterEventToState>();

  final ProgressDialog _progressDialog = ProgressDialog();

  Future _request(String name) async {
    return await eventToState.mapEventToState(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Application'),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            child: Text("Character Page"),
            onPressed: () async {
              _progressDialog.showProgressDialog(context);

              CharacterPageController.initializeOffset();

              var result = CharacterPageController.initializeContentCharacter(
                  await _request("Hulk"));

              if (result == state.CharacterSuccess) {
                _progressDialog.dismissProgressDialog(context);

                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterPage(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
