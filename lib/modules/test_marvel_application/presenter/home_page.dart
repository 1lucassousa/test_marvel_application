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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Lucas de Jesus Sousa'),
              accountEmail: Text('Test for Flutter Developer'),
              currentAccountPicture: CircleAvatar(
                radius: 30,
                child: Image.asset("assets/user.png"),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade900,
                    Colors.red.shade700,
                    Colors.red.shade500,
                    Colors.red.shade300,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  )
                ],
              ),
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Marvel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade900,
                Colors.red.shade700,
                Colors.red.shade500,
                Colors.red.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5, 5),
                blurRadius: 10,
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
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
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade900,
                        Colors.red.shade700,
                        Colors.red.shade500,
                        Colors.red.shade300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'All Characters',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  CharacterPageController.clear();
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchNamePage(),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade900,
                        Colors.red.shade700,
                        Colors.red.shade500,
                        Colors.red.shade300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Search Characters',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
