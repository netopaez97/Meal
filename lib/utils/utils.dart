import 'package:flutter/material.dart';
import 'dart:math';

const MaterialColor blackColor = MaterialColor(
  _blackColorValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackColorValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackColorValue = 0xff241C24;

const MaterialColor orangeColor = MaterialColor(
  _orangeColorValue,
  <int, Color>{
    100: Color(0xFFFFB74D),
    300: Color(0xFFFFA726),
    500: Color(_orangeColorValue),
    600: Color(0xFFE65100),
  },
);
const int _orangeColorValue = 0xffF26722;

const double pageWidthPresentation = 221;

Color orangeColors = Color(0xffF26721);
Color blackColors = Color(0xff241C24);

const APP_ID = 'ac01209f46b941609433beebc11b1929';

double roundDouble(double value) {
  double mod = pow(10.0, 2);
  return ((value * mod).round().toDouble() / mod);
}

String host = 'host';
String guest = 'guest';
String noguests = 'noguests';
