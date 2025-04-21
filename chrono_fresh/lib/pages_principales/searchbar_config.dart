import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'produits.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE produits(
            id INTEGER PRIMARY KEY,
            name TEXT,
            foto TEXT,
            info TEXT,
            price REAL,
            cat REAL
          )
        ''');
      },
    );
  }

  // Insert product
  Future<void> insertProduct(String id, String name, String foto, String info,
      String price, String cat) async {
    final db = await database;
    await db.insert(
      'produits',
      {
        'id': id,
        'name': name,
        'foto': foto,
        'info': info,
        'price': price,
        'cat': cat,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Search products
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final db = await database;
    return await db.query(
      'produits',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }
}
