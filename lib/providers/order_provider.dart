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
    // print("DATE: ${DateTime.now().subtract(Duration(days: 15))}");
    // final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().subtract(Duration(days: 15)).millisecondsSinceEpoch);
    // .where('data', isGreaterThanOrEqualTo: DateTime.now().subtract(new Duration(days: 5)))
    return _db.where('idUser', isEqualTo: prefs.uid).where("date", isLessThan: new DateTime.now()).snapshots();
  }
}
