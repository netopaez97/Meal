import 'package:flutter/material.dart';

class VariableProvider with ChangeNotifier {
  double _total;

  double get total => this._total;
  set total(double valor) {
    this._total = valor;
  }
}
