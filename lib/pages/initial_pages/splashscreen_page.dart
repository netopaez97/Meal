import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/widgets/widgets.dart';

class SplashscreenPage extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushNamedAndRemoveUntil(
            context, Routes.initial, (Route routes) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff241C24),
      body: Center(
        child: Meal(),
      ),
    );
  }
}
