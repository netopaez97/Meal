import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsProvider /* with ChangeNotifier*/ {
  CollectionReference _db = Firestore.instance.collection("products");

  Stream getAllProductosAvaliable() {
    return _db.where('availability', isEqualTo: true).snapshots();
  }

   Stream getProduct(String id) {
    
    final res = _db.document(id).snapshots();
    print(res);

    return res;
  }
}
