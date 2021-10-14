import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_marvel_application/modules/test_marvel_application/presenter/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
      color: Colors.red.shade900,
      child: Center(
        child: Image.asset("assets/giphy.gif"),
      ),
    );
  }
}
