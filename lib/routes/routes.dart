import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';
import 'package:meal/pages/date_page.dart';
import 'package:meal/pages/email_guest_page.dart';
import 'package:meal/pages/phone_guest_page.dart';
import 'package:meal/pages/phone_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (BuildContext context) => HomePage(),
    PhonePage.routeName: (BuildContext context) => PhonePage(),
    GuestPage.routeName: (BuildContext context) => GuestPage(),
    EmailPage.routeName: (BuildContext context) => EmailPage(),
    DatePage.routeName: (BuildContext context) => DatePage(),
  };
}

class Routes {
  static const String home = HomePage.routeName;
  static const String phone = PhonePage.routeName;
  static const String guestPhone = GuestPage.routeName;
  static const String guestEmail = EmailPage.routeName;
  static const String date = DatePage.routeName;
}
