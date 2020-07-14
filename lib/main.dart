import 'package:meal/providers/push_nofitications_provider.dart';
import 'package:meal/providers/variable_provider.dart';
import 'package:meal/services/dynamic_link_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/guest_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GuestProvider()),
      ChangeNotifierProvider(create: (_) => VariableProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _dynamicLinkService.initDynamicLinks(navigatorKey);
    super.initState();
    int contador = 1;
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((data) {
      print('Argumento del push');
      print(data);
      if (data != 'Message' && contador == 0) {
        contador++;
        print(contador);
        navigatorKey.currentState.pushNamed(Routes.order);
      } else {
        print(contador);
        contador = 0;
        print(contador);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'MEAL',
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryColor: utils.blackColor, primarySwatch: Colors.orange),
      initialRoute: Routes.initial,
      routes: getApplicationRoutes(),
    );
  }
}
