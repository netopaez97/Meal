import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsProvider /* with ChangeNotifier*/ {
  CollectionReference _db = Firestore.instance.collection("products");

  Stream getAllProductosAvaliable() {
    return _db.where('availability', isEqualTo: true).snapshots();
  }

   Future getProduct(String id) {
    
    final res = _db.document(id).get();
    print("Respuesta desde provider producto: $res");

    return res;
  }
}
