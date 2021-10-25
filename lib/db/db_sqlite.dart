// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, library_prefixes, avoid_print

import 'package:product_app_demo/model/productModel.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';

class DBSqlite {
  static var productList = [];

  // it's for create table
  static final String CREATE_TABLE_PRODUCT = ''' create table $TABLE_PRODUCT(
    $COL_PRODUCT_ID integer primary key autoincrement,
    $COL_PRODUCT_NAME text not null,
    $COL_PRODUCT_PRICE real not null,
    $COL_PRODUCT_CATGORY text not null,
    $COL_PRODUCT_DATE text not null,
    $COL_PRODUCT_IMAGE text not null
  ) ''';

  static Future<Database> open() async {
    final root = await getDatabasesPath();
    final dbPath = Path.join(root, 'product_db');
    return openDatabase(dbPath, version: 9, onCreate: (db, version) async {
      await db.execute(CREATE_TABLE_PRODUCT);
    }, onUpgrade: (db, oldVersion, newVersion) {
      print("onUpgrade");
      if (newVersion == 9) {
        db.execute(
            'alter table $TABLE_PRODUCT add column $COL_PRODUCT_FAVORITE integer');
      }
    });
  }

  static Future<int> insertProduct(Product product) async {
    final db = await open();
    return db.insert(TABLE_PRODUCT, product.toMap());
  }

  static Future<List<Product>> getAllProduct() async {
    final db = await open();
    final List<Map<String, dynamic>> productMap = await db.query(TABLE_PRODUCT);
    return List.generate(productMap.length, (index) {
      return Product.fromMap(productMap[index]);
    });
  }

  static Future<Product> getProductById(int id) async {
    final db = await open();
    final List<Map<String, dynamic>> productListMap = await db
        .query(TABLE_PRODUCT, where: '$COL_PRODUCT_ID=?', whereArgs: [id]);
    if (productListMap.length > 0) {
      return Product.fromMap(productListMap.first);
    }
    return Product(id);
  }

  static Future<int> deleteProduct(int id) async {
    final db = await open();

    return db
        .delete(TABLE_PRODUCT, where: '$COL_PRODUCT_ID=?', whereArgs: [id]);
  }

  static Future updateisFav(int id, int value) async {
    final db = await open();
    db.update(TABLE_PRODUCT, {COL_PRODUCT_FAVORITE: value},
        where: '$COL_PRODUCT_ID = ?', whereArgs: [id]);
  }
}
