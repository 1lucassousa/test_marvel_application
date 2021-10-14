import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/home_page.dart';

class SpashPage extends StatefulWidget {
  @override
  _SpashPageState createState() => _SpashPageState();
}

class _SpashPageState extends State<SpashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        
      ),
    );
  }
}
