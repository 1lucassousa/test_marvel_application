import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/character_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/controller/page_controller/character_page_controller.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/details_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/event_to_state/character_event_to_state.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/state/state.dart'
    as state;

class CharacterPage extends StatefulWidget {
  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  ScrollController _scrollController = ScrollController();
  final eventToState = Modular.get<CharacterEventToState>();

  int i;
  bool isPerformingRequest = false;

  Future _request(String name) async {
    return await eventToState.mapEventToState(name);
  }

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          CharacterPageController.page + 1 <
              CharacterPageController.totalPages()) {
        _getMoreData();
      }
    });
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
      if (CharacterPageController.page + 1 <=
          CharacterPageController.totalPages()) {
        CharacterPageController.pagination();

        var result =
            CharacterPageController.addCharactersToList(await _request('Hulk'));

        if (result == state.CharacterSuccess) {
          setState(() {
            print("Pagina Atual: " + CharacterPageController.page.toString());
            print("Total pagina: " +
                CharacterPageController.totalPages().toString());
            isPerformingRequest = false;
          });
        }
      }
    }
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            height: MediaQuery.of(context).size.height * 0.175,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount:
                  CharacterController.contentCharacterModel.results.length + 1,
              itemBuilder: (context, index) {
                if (index ==
                    CharacterController.contentCharacterModel.results.length) {
                  return _buildProgressIndicator();
                } else {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              print(index);
                              i = index;
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(CharacterController
                                        .contentCharacterModel
                                        .results[index]
                                        .imagePath),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(CharacterController
                                    .contentCharacterModel
                                    .results[index]
                                    .characterName),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
          i != null
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.825,
                  child: ListView(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(CharacterController
                                .contentCharacterModel.results[i].imagePath),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              CharacterController
                                  .contentCharacterModel.results[i].name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              CharacterController.contentCharacterModel
                                      .results[i].description.isEmpty
                                  ? "Without Description"
                                  : CharacterController.contentCharacterModel
                                      .results[i].description,
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text('More Information'),
                                onPressed: () {
                                  return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                          CharacterController
                                              .contentCharacterModel
                                              .results[i]),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
