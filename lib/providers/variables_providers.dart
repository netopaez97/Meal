import 'package:flutter/foundation.dart';
import 'package:meal/providers/shopping_cart_provider.dart';

class VariablesProvider with ChangeNotifier {
  double _total = 0.0;
  double get total => this._total;
  set total(double valor) {
    this._total = valor;
  }

  getTotal() async {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();
    final list = await _shoppingCartProvider.getShoppingCart();
    this._total = 0.0;
    list.forEach((e) {
      this._total = this._total + e.totalPrice;
    });
    return this._total;
  }
}
