import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/searchbar_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

DatabaseHelper dbHelper = DatabaseHelper();

Future<void> fetchAndStoreProducts() async {
  try {
    final response = await http.get(
      Uri.parse('$api_link/api_fresh/allproducts.php'),
    );

    if (response.statusCode == 200) {
      List<dynamic> products = json.decode(response.body);
      print("✅ ${products.length} produits téléchargés depuis l’API.");

      // Insérer chaque produit dans SQLite
      for (var product in products) {
        await dbHelper.insertProduct({
          'id': product['id'] ?? 0,
          'name': product['nom'] ?? '',
          'foto': product['image'] ?? '',
          'info': product['description'] ?? '',
          'price': double.tryParse(product['prix'].toString()) ?? 0.0,
          'cat': product['categorie']?.toString() ?? '',
        });
      }

      print("✅ Produits enregistrés localement !");
    } else {
      print("❌ Erreur API : ${response.statusCode}");
      throw Exception('Erreur lors du chargement des produits');
    }
  } catch (e) {
    print("⚠️ Erreur dans fetchAndStoreProducts: $e");
  }
}
