import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEAL',
      theme: ThemeData(
        primaryColor: utils.blackColor,
        primarySwatch: Colors.orange
      ),
      initialRoute: Routes.phone,
      routes: getApplicationRoutes(),
    );
  }
}