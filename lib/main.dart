import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_marvel_application/app_module.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
    ),
  );
}
