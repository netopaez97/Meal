import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';
import 'package:meal/pages/initial_pages/date_page.dart';
import 'package:meal/pages/initial_pages/guest_email_page.dart';
import 'package:meal/pages/initial_pages/guest_phone_page.dart';
import 'package:meal/pages/initial_pages/host_email_page.dart';
import 'package:meal/pages/initial_pages/host_phone_page.dart';
import 'package:meal/pages/initial_pages/landing_page.dart';
import 'package:meal/pages/initial_pages/menu_page.dart';
import 'package:meal/pages/initial_pages/payment_page.dart';
import 'package:meal/pages/initial_pages/pick_up_page.dart';
import 'package:meal/pages/initial_pages/selection_page.dart';
import 'package:meal/pages/initial_pages/splashscreen_page.dart';
import 'package:meal/pages/login/login_page.dart';
import 'package:meal/pages/orders.dart';
import 'package:meal/pages/payment/order_page.dart';
import 'package:meal/pages/shopping_cart_page.dart';
import 'package:meal/pages/video_conference/conference_page.dart';
// import 'package:meal/pages/video_conference/conference_page.dart';
import 'package:meal/pages/video_conference/index_conference.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (BuildContext context) => HomePage(),
    PhonePage.routeName: (BuildContext context) => PhonePage(),
    HostEmailPage.routeName: (BuildContext context) => HostEmailPage(),
    EmailPage.routeName: (BuildContext context) => EmailPage(),
    GuestPage.routeName: (BuildContext context) => GuestPage(),
    DatePage.routeName: (BuildContext context) => DatePage(),
    ConferencePage.routeName :    (BuildContext context) => ConferencePage(),
    IndexPage.routeName: (BuildContext context) => IndexPage(),
    SelectionPage.routeName: (BuildContext context) => SelectionPage(),
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    InitialPage.routeName: (BuildContext context) => InitialPage(),
    ShoppingCartPage.routeName: (BuildContext context) => ShoppingCartPage(),
    SplashscreenPage.routeName: (BuildContext context) => SplashscreenPage(),
    OrdersPage.routeName: (BuildContext context) => OrdersPage(),
    OrderPage.routeName: (BuildContext context) => OrderPage(),
    PickUpPage.routeName: (BuildContext context) => PickUpPage(),
    PaymentPage.routeName: (BuildContext context) => PaymentPage(),
    MenuPage.routeName: (BuildContext context) => MenuPage(),
  };
}

class Routes {
  static const String home = HomePage.routeName;
  static const String hostPhone = PhonePage.routeName;
  static const String hostEmail = HostEmailPage.routeName;
  static const String guestPhone = GuestPage.routeName;
  static const String guestEmail = EmailPage.routeName;
  static const String date = DatePage.routeName;
  static const String conference         = ConferencePage.routeName;
  static const String indexConference = IndexPage.routeName;
  static const String selection = SelectionPage.routeName;
  static const String login = LoginPage.routeName;
  static const String initial = InitialPage.routeName;
  static const String car = ShoppingCartPage.routeName;
  static const String splash = SplashscreenPage.routeName;
  static const String orders = OrdersPage.routeName;
  static const String order = OrderPage.routeName;
  static const String pickup = PickUpPage.routeName;
  static const String payment = PaymentPage.routeName;
  static const String menu = MenuPage.routeName;
}
