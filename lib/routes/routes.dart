import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';
import 'package:meal/pages/date_page.dart';
import 'package:meal/pages/email_guest_page.dart';
import 'package:meal/pages/phone_guest_page.dart';
import 'package:meal/pages/phone_page.dart';
import 'package:meal/pages/selection_page.dart';
// import 'package:meal/pages/video_conference/conference_page.dart';
import 'package:meal/pages/video_conference/index_conference.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName:           (BuildContext context) => HomePage(),
    PhonePage.routeName:          (BuildContext context) => PhonePage(),
    EmailPage.routeName:          (BuildContext context) => EmailPage(),
    GuestPage.routeName:          (BuildContext context) => GuestPage(),
    DatePage.routeName:           (BuildContext context) => DatePage(),
    // ConferencePage.routeName :    (BuildContext context) => ConferencePage(),
    IndexPage.routeName :    (BuildContext context) => IndexPage(),
    SelectionPage.routeName :    (BuildContext context) => SelectionPage(),
  };
}

class Routes {
  static const String home          = HomePage.routeName;
  static const String phone         = PhonePage.routeName;
  static const String guestPhone    = GuestPage.routeName;
  static const String guestEmail    = EmailPage.routeName;
  static const String date          = DatePage.routeName;
  // static const String conference    = ConferencePage.routeName;
  static const String indexConference    = IndexPage.routeName;
  static const String selection    = SelectionPage.routeName;
}
