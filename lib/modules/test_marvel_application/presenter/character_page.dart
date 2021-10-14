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
            CharacterPageController.addCharactersToList(await _request(''));

        if (result == state.CharacterSuccess) {
          setState(() {
            isPerformingRequest = false;
          });
        } else {
          isPerformingRequest = false;
          _alert(context, result);
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
        title: Text(
          "Characters",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                if (CharacterPageController.getIsList() != true) {
                  setState(() {
                    CharacterPageController.setIsList(true);
                  });
                }
              },
              child: Icon(
                Icons.list_alt_sharp,
                size: 26.0,
                color: CharacterPageController.getIsList()
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              //vertical
              onTap: () async {
                if (CharacterPageController.getIsList() != false) {
                  setState(() {
                    CharacterPageController.setIsList(false);
                  });
                }
              },
              child: Icon(
                Icons.view_comfortable,
                size: 32.0,
                color: CharacterPageController.getIsList()
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
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
      body: CharacterPageController.getIsList()
          ? buildListViewVertical(context)
          : buildListViewHorizontal(context),
    );
  }

  ListView buildListViewVertical(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: CharacterController.contentCharacterModel.results.length + 1,
      itemBuilder: (context, index) {
        if (index == CharacterController.contentCharacterModel.results.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(CharacterController
                  .contentCharacterModel.results[index].imagePath),
            ),
            title: Text(
                CharacterController.contentCharacterModel.results[index].name),
            onTap: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                      CharacterController.contentCharacterModel.results[index]),
                ),
              );
            },
          );
        }
      },
    );
  }

  GridView buildListViewHorizontal(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: CharacterController.contentCharacterModel.results.length + 1,
      itemBuilder: (context, index) {
        if (index == CharacterController.contentCharacterModel.results.length) {
          return _buildProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                      CharacterController.contentCharacterModel.results[index]),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(CharacterController
                          .contentCharacterModel.results[index].imagePath),
                    ),
                  ),
                ),
                Container(
                  child: Text(CharacterController
                      .contentCharacterModel.results[index].characterName),
                )
              ],
            ),
          );
        }
      },
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
