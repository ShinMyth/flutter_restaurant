import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? db;
String dbName = "cart.db";

class SqfliteDatabaseService {
  Future<void> setupDatabase() async {
    var path = await getDatabasesPath();
    String databasesPath = join(path, dbName);

    db = await openDatabase(
      databasesPath,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE cart (
      id INTEGER PRIMARY KEY,
      cartItemID TEXT NOT NULL,
      cartItemImage TEXT NOT NULL,
      cartItemName TEXT NOT NULL,
      cartItemPrice REAL NOT NULL,
      cartItemQuantity INTEGER NOT NULL,
      cartItemGrossTotal REAL NOT NULL
    )
    """);
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
