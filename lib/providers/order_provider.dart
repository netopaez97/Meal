import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/order_model.dart';
import 'package:meal/preferences/userpreferences.dart';

class OrderProvider /* with ChangeNotifier*/ {
  CollectionReference _db = Firestore.instance.collection("orders");
  final prefs = new UserPreferences();

  insertOrder(OrderModel order) async {
    final data = orderModelToJson(order);
    final res = await _db.add(jsonDecode(data));
    print(res);
    if (res.documentID.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Stream getOrders() {
    return _db.where('idUser', isEqualTo: prefs.uid).snapshots();
  }
}
