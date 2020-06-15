import 'package:flutter/foundation.dart';

class VariablesProvider with ChangeNotifier {
  double _total = 0.0;
  double get total => this._total;
  set total(double valor) {
    this._total = valor;
  }
}
