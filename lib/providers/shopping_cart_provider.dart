import 'dart:io';

import 'package:meal/models/product_model.dart';
import 'package:meal/models/shopping_cart_model.dart';
export 'package:meal/models/shopping_cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ShoppingCartProvider {
  static Database _database;
  static final ShoppingCartProvider db = ShoppingCartProvider();
  final String _table = 'ShoppingCart';

  ShoppingCartProvider();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ShoppingCartDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ShoppingCart ('
          'idCar INTEGER PRIMARY KEY,'
          'idProduct TEXT,'
          'quantityProducts INTEGER,'
          'price DOUBLE,'
          'productComment TEXT'
          ')');
    });
  }

  //AGREGAR REGISTROS

  newShoppingCart(ShoppingCartModel shoppingCart) async {
    final db = await database;
    final resId = await db.query(
      _table,
      where: 'idProduct = ?',
      whereArgs: [shoppingCart.idProduct],
    );
    if (resId.isEmpty) {
      final res = await db.insert(_table, shoppingCart.toJson());
      return res;
    } else {
      shoppingCart.quantityProducts = shoppingCart.quantityProducts;
      shoppingCart.idCar = resId[0]["idCar"];

      return await db.update(_table, shoppingCart.toJson(),
          where: 'idCar = ?', whereArgs: [shoppingCart.idCar]);
    }
  }

  //OBTENER REGISTROS

  Future getShoppingCart() async {
    final db = await database;
    final res = await db.query('ShoppingCart');
    List<ShoppingCartModel> list = res.isNotEmpty
        ? res.map((c) => ShoppingCartModel.fromJson(c)).toList()
        : [];
    return list;
  }

  getProductShoppingCart(ProductModel product) async {
    final db = await database;
    final res = await db.query(
      _table,
      where: 'idProduct = ?',
      whereArgs: [product.idProduct],
    );
    List<ShoppingCartModel> shoppingCart = res.isNotEmpty
        ? res.map((c) => ShoppingCartModel.fromJson(c)).toList()
        : [];
    return shoppingCart;
  }
  // BORRAR REGISTROS

  deleteShoppingCart(int id) async {
    final db = await database;
    final res =
        await db.delete('ShoppingCart', where: 'idCar = ?', whereArgs: [id]);
    return res;
  }

  deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM ShoppingCart');
    return res;
  }
}
