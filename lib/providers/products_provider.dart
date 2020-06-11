import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsProvider/* with ChangeNotifier*/{

  CollectionReference _db = Firestore.instance.collection("products");

  Stream getAllProductosAvaliable() {
    return _db.snapshots();
  }

} 