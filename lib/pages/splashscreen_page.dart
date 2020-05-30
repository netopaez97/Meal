import 'package:flutter/material.dart';
import 'package:meal/widgets/widgets.dart';

class SplashscreenPage extends StatelessWidget {
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
