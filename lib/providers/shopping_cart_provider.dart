import 'dart:io';

import 'package:meal/models/shopping_cart_model.dart';
export 'package:meal/models/shopping_cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ShoppingCartProvider {
  static Database _database;
  static final ShoppingCartProvider db = ShoppingCartProvider();

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
          'productComment TEXT'
          ')');
    });
  }

  //AGREGAR REGISTROS

  newShoppingCart(ShoppingCartModel shoppingCart) async {
    final db = await database;
    final res = await db.insert('ShoppingCart', shoppingCart.toJson());
    return res;
    // final resId = await db.query(
    //   'ShoppingCart',
    //   where: 'idProduct = ?',
    //   whereArgs: [shoppingCart.idProduct],
    // );
    // if (resId.isEmpty) {
    //   final res = await db.insert('ShoppingCart', shoppingCart.toJson());
    //   return res;
    // } else {
    //   return null;
    // }
  }

  //OBTENER REGISTROS

  getShoppingCart() async {
    final db = await database;
    final res = await db.query('ShoppingCart');
    List<ShoppingCartModel> list = res.isNotEmpty
        ? res.map((c) => ShoppingCartModel.fromJson(c)).toList()
        : [];
    return list;
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
