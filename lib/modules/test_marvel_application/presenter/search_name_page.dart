import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/character_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/details_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/event_to_state/character_event_to_state.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart'
    as state;

class SearchNamePage extends StatefulWidget {
  @override
  _SearchNamePageState createState() => _SearchNamePageState();
}

class _SearchNamePageState extends State<SearchNamePage> {
  final eventToState = Modular.get<CharacterEventToState>();
  final ProgressDialog _progressDialog = ProgressDialog();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future _request(String name) async {
      return await eventToState.mapEventToState(name);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Character",
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
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            _textFormField("Name", controller: nameController),
            Container(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text('Search'),
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    _alert(
                        context, 'You need to define a name for the survey.');
                  } else {
                    _progressDialog.showProgressDialog(context);

                    CharacterPageController.initializeOffset();

                    var result =
                        CharacterPageController.initializeContentCharacter(
                            await _request(nameController.text.toString()));

                    if (result == state.CharacterSuccess) {
                      _progressDialog.dismissProgressDialog(context);

                      if (CharacterController
                          .contentCharacterModel.results.isEmpty) {
                        _alert(context, 'Data Search Not Found');
                      } else {
                        setState(() {});
                      }
                    } else {
                      _progressDialog.dismissProgressDialog(context);
                      _alert(context, result);
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CharacterController.contentCharacterModel != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Result Search'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: CharacterController
                              .contentCharacterModel.results.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    CharacterController.contentCharacterModel
                                        .results[index].imagePath),
                              ),
                              title: Text(CharacterController
                                  .contentCharacterModel.results[index].name),
                              onTap: () {
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        CharacterController
                                            .contentCharacterModel
                                            .results[index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _textFormField(
    String label, {
    TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
        ),
        labelText: label,
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
