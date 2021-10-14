import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/app_widget.dart';
import 'package:test_marvel_application/modules/test_marvel_application/domain/usecase/search_character.dart';
import 'package:test_marvel_application/modules/test_marvel_application/external/datasource/search_character_api_datasource.dart';
import 'package:test_marvel_application/modules/test_marvel_application/infra/repository/search_character_repository.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/character_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/details_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/event_to_state/character_event_to_state.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/home_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/search_name_page.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/splash_page.dart';

class AppModule extends MainModule {
  @override
  // implement binds
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchCharacterImpl(i())),
        Bind((i) => SearchCharacterApiDatasource(i())),
        Bind((i) => SearchCharacterRepositoryImpl(i())),
        Bind((i) => CharacterEventToState(i()))
      ];

  @override
  // implement routers
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, __) => SplashPage()),
        ModularRouter('/', child: (_, __) => HomePage()),
        ModularRouter('/', child: (_, __) => CharacterPage()),
        ModularRouter('/', child: (_, __) => DetailsPage()),
        ModularRouter('/', child: (_, __) => SearchNamePage()),
      ];

  @override
  // implement bootstrap
  Widget get bootstrap => AppWidget();
}
