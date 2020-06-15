import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal/providers/variables_providers.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;
import 'package:provider/provider.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VariablesProvider()),
      ],
      child: MyApp(),
    ),
  );
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
      initialRoute: Routes.home,
      routes: getApplicationRoutes(),
    );
  }
}
