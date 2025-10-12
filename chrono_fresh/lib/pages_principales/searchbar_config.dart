import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:chrono_fresh/global_var.dart';

/// ✅ Classe principale de gestion de la base de données
class DatabaseHelper {
  static Database? _database;

  // --- OUVERTURE / INITIALISATION DE LA BASE ---
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
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

  // --- INSÉRER UN PRODUIT ---
  Future<void> insertProduct(Map<String, dynamic> produit) async {
    final db = await database;
    await db.insert('produits', produit,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // --- RÉCUPÉRER TOUS LES PRODUITS ---
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('produits');
  }

  // --- RECHERCHER UN PRODUIT PAR NOM ---
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final db = await database;
    return await db.query(
      'produits',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
  }

  // --- VIDER LA TABLE ---
  Future<void> clearProducts() async {
    final db = await database;
    await db.delete('produits');
  }

  // --- SYNCHRONISER AVEC L’API DISTANTE ---
  Future<void> syncProduits() async {
    try {
      print("🔄 Synchronisation avec l’API en cours...");

      final response = await http.get(
        Uri.parse('$api_link/api_fresh/allproducts.php'),
      );

      if (response.statusCode != 200) {
        print("❌ Erreur API : ${response.statusCode}");
        return;
      }

      List<dynamic> produits = json.decode(response.body);

      if (produits is! List) {
        print("❌ Format API invalide !");
        return;
      }

      final db = await database;
      await db.delete('produits'); // Réinitialise les données locales
      final batch = db.batch();

      for (var p in produits) {
        batch.insert('produits', {
          'id': p['id'] ?? 0,
          'name': p['nom'] ?? '',
          'foto': p['image'] ?? '',
          'info': p['description'] ?? '',
          'price': double.tryParse(p['prix'].toString()) ?? 0.0,
          'cat': p['categorie']?.toString() ?? '',
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
      print("✅ ${produits.length} produits enregistrés localement !");
    } catch (e) {
      print("⚠️ Erreur dans syncProduits : $e");
    }
  }
}

/// ✅ Instance globale accessible depuis toute ton app
final DatabaseHelper dbHelper = DatabaseHelper();

/// --- UTILISATION DANS TA BARRE DE RECHERCHE ---
/// Exemple d’appel dans `searchbar_config.dart`
///
/// ```dart
/// Future<List<Map<String, dynamic>>> searchProduits(String query) async {
///   if (query.isEmpty) {
///     return await dbHelper.getAllProducts();
///   } else {
///     return await dbHelper.searchProducts(query);
///   }
/// }
/// ```
///
/// Et avant de lancer la recherche, pense à synchroniser au démarrage :
///
/// ```dart
/// await dbHelper.syncProduits(); // au lancement de l’app ou sur refresh
/// ```

