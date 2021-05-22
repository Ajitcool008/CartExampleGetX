import 'dart:io';
import 'package:cartdoodbleblue/src/models/cart_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  String colId = 'Id';
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the cart table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'cart_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Carts('
          'name TEXT,'
          'price TEXT,'
          'description TEXT,'
          'id INTEGER,'
          'packageItemsCount INTEGER'
          ')');
    });
  }

  // Insert cart on database
  Future<void> createCarts(ProductData cart) async {
    //await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('Carts', cart.toJson());
    return res;
  }

  Future<void> deleteCarts(ProductData cart) async {
    final deleteid = cart.id;
    final db = await database;

    final res = await db.rawQuery(
        "Delete from CARTS where rowid IN (Select rowid from CARTS WHERE id =? limit 1)",
        ['$deleteid']);

    return res;
  }

  Future<List<ProductData>> getCarts() async {
    final db = await database;

    final res = await db.rawQuery(
        "SELECT sum(price) AS price,count(id) AS packageItemsCount,max(description) as description,max(name) as name,  max(id) as id  FROM CARTS group by id");
    List<ProductData> list = res.isNotEmpty
        ? res.map<ProductData>((json) => ProductData.fromDb(json)).toList()
        : [];

    return list;
  }

  Future<List<ProductData>> getCompleteCarts() async {
    final db = await database;

    final res = await db.rawQuery("SELECT * FROM CARTS ");

    List<ProductData> list = res.isNotEmpty
        ? res.map<ProductData>((json) => ProductData.fromDb(json)).toList()
        : [];

    return list;
  }

  Future<List<ProductData>> getSingleCarts() async {
    final db = await database;

    final res = await db.rawQuery(
        "SELECT max(discount_price) AS discount_price,max(price) AS price, max(duration) AS duration, count(id) AS package_items_count,max(main_image) as main_image,max(description) as description,max(name) as name,  max(id) as id  FROM CARTS group by id");
    List<ProductData> list = res.isNotEmpty
        ? res.map<ProductData>((json) => ProductData.fromDb(json)).toList()
        : [];

    return list;
  }

  Future<int> deleteAllUsers() async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM CARTS");

    return res;
  }

  Future close() async {
    final db = await database;
    final res = await db.close();

    return res;
  }
}
