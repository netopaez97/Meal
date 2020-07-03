import 'package:flutter/material.dart';

class GuestProvider with ChangeNotifier {
  int _guestCount = 0;
  int _phone;
  List<int> _guests = new List();

  int get guestCount => this._guestCount;
  set guestCount(int valor) {
    this._guestCount = valor;
    notifyListeners();
  }

  int get phone => this._phone;
  set phone(int valor) {
    this._phone = valor;
    notifyListeners();
  }

  List<int> get guests => this._guests;
  set guests(List<int> valor) {
    this._guests = valor;
    notifyListeners();
  }

  setGuests(int valor) {
    this._guests.add(valor);
    notifyListeners();
  }
}
