import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'MEAL',
      theme: ThemeData(
          primaryColor: utils.blackColor, primarySwatch: Colors.orange),
      initialRoute: Routes.splash,
      routes: getApplicationRoutes(),
    );
  }
}
