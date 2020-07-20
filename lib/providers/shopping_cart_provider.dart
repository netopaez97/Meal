import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/utils/utils.dart';

class ShoppingCartProvider {
  final CollectionReference _collectionReferenceDB =
      Firestore.instance.collection("users");
  final String _table = 'shoppingcart';
  UserPreferences prefs = UserPreferences();

  ///Agregar producto a BD de cada restaurante
  ///1. Verificar que no hay productos con el mismo id guardados.
  ///2. Si ya hay guardados, actualizar la cantidad de productos
  ///Si no hay guardados, agregarlo, no actualziarlo.
  Future newShoppingCart(ShoppingCartModel _productCart) async {
    if (prefs.uid.isEmpty) {
      prefs.uid = DateTime.now().toString();
    }

    final resId = await _collectionReferenceDB
        .document(prefs.uid)
        .collection(_table)
        .where("idProduct", isEqualTo: _productCart.idProduct)
        .where("mealFor", isEqualTo: _productCart.mealFor)
        .getDocuments();

    if (resId.documents.isEmpty) {
      return await _collectionReferenceDB
          .document(prefs.uid)
          .collection(_table)
          .add(_productCart.toJson());
    } else {
      return await _collectionReferenceDB
          .document(prefs.uid)
          .collection(_table)
          .document(resId.documents[0].documentID)
          .setData(_productCart.toJson());
    }
  }

  //Este método devuelve la cantidad de productos que han sido guardados en la base de datos
  getProductShoppingCart(ProductModel product, mealFor) async {
    var res;
    if (prefs.uid.isEmpty) {
      prefs.uid = DateTime.now().toString();
    }
    ShoppingCartModel shoppingCartModel = ShoppingCartModel();
    if (prefs.rol == guest) {
      final resUser = await _collectionReferenceDB
          .where('phone', isEqualTo: int.parse(prefs.host.split(' - ')[1]))
          .getDocuments();

      res = await _collectionReferenceDB
          .document(resUser.documents[0].documentID)
          .collection(_table)
          .where("idProduct", isEqualTo: product.idProduct)
          .where("mealFor", isEqualTo: mealFor)
          .getDocuments();
    } else {
      res = await _collectionReferenceDB
          .document(prefs.uid)
          .collection(_table)
          .where("idProduct", isEqualTo: product.idProduct)
          .where("mealFor", isEqualTo: mealFor)
          .getDocuments();
    }

    if (res.documents.isEmpty) {
      return shoppingCartModel;
    } else {
      shoppingCartModel =
          shoppingCartModelFromJson(jsonEncode(res.documents[0].data));
      shoppingCartModel.idCar = res.documents[0].documentID;
    }

    return shoppingCartModel;
  }

  getShoppingCart() async {
    List<ShoppingCartModel> list = [];
    ShoppingCartModel shoppingCartModel = ShoppingCartModel();

    final res = await _collectionReferenceDB
        .document(prefs.uid)
        .collection(_table)
        .getDocuments();
    if (res.documents.isEmpty) {
      return list;
    }
    res.documents.forEach((element) {
      shoppingCartModel = shoppingCartModelFromJson(jsonEncode(element.data));
      shoppingCartModel.idCar = element.documentID;
      list.add(shoppingCartModel);
    });

    return list;
  }

  getShoppingCartMealFor(String mealFor) async {
    List<ShoppingCartModel> list = [];
    ShoppingCartModel shoppingCartModel = ShoppingCartModel();
    final res = await _collectionReferenceDB
        .document(prefs.uid)
        .collection(_table)
        .where('mealFor', isEqualTo: mealFor)
        .getDocuments();
    if (res.documents.isEmpty) {
      return list;
    }
    res.documents.forEach((element) {
      shoppingCartModel = shoppingCartModelFromJson(jsonEncode(element.data));
      shoppingCartModel.idCar = element.documentID;
      list.add(shoppingCartModel);
    });

    return list;
  }

  deleteAll() async {
    List<ShoppingCartModel> list = [];
    ShoppingCartModel shoppingCartModel = ShoppingCartModel();
    final res = await _collectionReferenceDB
        .document(prefs.uid)
        .collection(_table)
        .getDocuments();
    if (res.documents.isEmpty) {
      return null;
    }
    res.documents.forEach((element) {
      shoppingCartModel = shoppingCartModelFromJson(jsonEncode(element.data));
      shoppingCartModel.idCar = element.documentID;
      list.add(shoppingCartModel);
    });
    list.forEach((element) async {
      await _collectionReferenceDB
          .document(prefs.uid)
          .collection(_table)
          .document(element.idCar)
          .delete();
    });
  }

  deleteShoppingCart(String _idCarrito) async {
    final res = await _collectionReferenceDB
        .document(prefs.uid)
        .collection(_table)
        .document(_idCarrito)
        .delete();
    return res;
  }
}
