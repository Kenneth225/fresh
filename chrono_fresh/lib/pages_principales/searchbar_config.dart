/*import 'package:path/path.dart';
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
*/

import 'package:chrono_fresh/controlleurs/boutique_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';// ✅ ton modèle produit (si tu en as un)
import 'dart:async';

class DatabaseHelper {
  static Database? _database;

  // --- 1️⃣ OUVERTURE OU INITIALISATION DE LA BASE ---
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
            cat TEXT
          )
        ''');
      },
    );
  }

  // --- 2️⃣ INSÉRER UN PRODUIT ---
  Future<void> insertProduct(Map<String, dynamic> produit) async {
    final db = await database;
    await db.insert(
      'produits',
      produit,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --- 3️⃣ RÉCUPÉRER TOUS LES PRODUITS ---
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('produits');
  }

  // --- 4️⃣ RECHERCHER DES PRODUITS ---
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final db = await database;
    return await db.query(
      'produits',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }

  // --- 5️⃣ VIDER LA TABLE ---
  Future<void> clearProducts() async {
    final db = await database;
    await db.delete('produits');
  }

  // --- 6️⃣ SYNCHRONISER AVEC L'API DISTANTE ---
  Future<void> syncProduits() async {
    final db = await database;

    // 🔹 Étape 1 : vider l'ancienne table (optionnel)
    await db.delete('produits');

    // 🔹 Étape 2 : récupérer les produits depuis ton API
    final produits = await viewboutique(1); // <- ta fonction API

    // 🔹 Étape 3 : insérer chaque produit localement
    for (var p in produits) {
      await insertProduct({
        'id': p.id,
        'name': p.nom,
        'foto': p.image,
        'info': p.description ?? '',
        'price': double.tryParse(p.prix.toString()) ?? 0.0,
        'cat': p.categorie,
      });
    }

    print("✅ Synchronisation terminée : ${produits.length} produits insérés.");
  }
}
