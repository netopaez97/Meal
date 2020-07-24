import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsProvider /* with ChangeNotifier*/ {
  CollectionReference _db = Firestore.instance.collection("products");

  Stream getAllProductosAvaliable() {
    return _db.where('availability', isEqualTo: true).limit(5).snapshots();
  }

  Future getProduct(String id) {
    final res = _db.document(id).get();

    return res;
  }

  Stream getProductsByCategory(String _category){
    return _db.where('category', isEqualTo: _category).where('availability', isEqualTo: true).snapshots();
  }
}
