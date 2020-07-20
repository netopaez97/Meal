import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';
import 'package:meal/pages/initial_pages/date_page.dart';
import 'package:meal/pages/initial_pages/guest_phone_page.dart';
import 'package:meal/pages/initial_pages/host_phone_page.dart';
import 'package:meal/pages/initial_pages/landing_page.dart';
import 'package:meal/pages/initial_pages/menu_page.dart';
import 'package:meal/pages/initial_pages/payment_page.dart';
import 'package:meal/pages/initial_pages/pick_up_page.dart';
import 'package:meal/pages/initial_pages/selection_page.dart';
import 'package:meal/pages/login/login_page.dart';
import 'package:meal/pages/order/order_page.dart';
import 'package:meal/pages/orders_completed/orders.dart';
import 'package:meal/pages/order/shopping_cart_page.dart';
import 'package:meal/pages/video_conference/conference_page.dart';
import 'package:meal/pages/video_conference/index_conference.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePage.routeName: (BuildContext context) => HomePage(),
    PhonePage.routeName: (BuildContext context) => PhonePage(),
    GuestPage.routeName: (BuildContext context) => GuestPage(),
    DatePage.routeName: (BuildContext context) => DatePage(),
    ConferencePage.routeName: (BuildContext context) => ConferencePage(),
    IndexPage.routeName: (BuildContext context) => IndexPage(),
    SelectionPage.routeName: (BuildContext context) => SelectionPage(),
    LoginPage.routeName: (BuildContext context) => LoginPage(),
    InitialPage.routeName: (BuildContext context) => InitialPage(),
    ShoppingCartPage.routeName: (BuildContext context) => ShoppingCartPage(),
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
  static const String guestPhone = GuestPage.routeName;
  static const String date = DatePage.routeName;
  static const String conference = ConferencePage.routeName;
  static const String indexConference = IndexPage.routeName;
  static const String selection = SelectionPage.routeName;
  static const String login = LoginPage.routeName;
  static const String initial = InitialPage.routeName;
  static const String car = ShoppingCartPage.routeName;
  static const String orders = OrdersPage.routeName;
  static const String order = OrderPage.routeName;
  static const String pickup = PickUpPage.routeName;
  static const String payment = PaymentPage.routeName;
  static const String menu = MenuPage.routeName;
}
