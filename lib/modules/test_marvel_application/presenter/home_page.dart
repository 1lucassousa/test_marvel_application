import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/character_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/event_to_state/character_event_to_state.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/search_name_page.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text("All Character"),
                onPressed: () async {
                  _progressDialog.showProgressDialog(context);

                  CharacterPageController.clear();

                  var result =
                      CharacterPageController.initializeContentCharacter(
                          await _request(""));

                  if (result == state.CharacterSuccess) {
                    _progressDialog.dismissProgressDialog(context);

                    return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterPage(),
                      ),
                    );
                  } else {
                    _progressDialog.dismissProgressDialog(context);
                    _alert(context, (result).error.status);
                  }
                },
              ),
              TextButton(
                child: Text("Search Character"),
                onPressed: () async {
                  CharacterPageController.clear();
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchNamePage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _alert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
