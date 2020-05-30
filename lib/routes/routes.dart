import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName                             : ( BuildContext context ) => HomePage(),
  };
}

class Routes {
  static const String home                         = HomePage.routeName;
}