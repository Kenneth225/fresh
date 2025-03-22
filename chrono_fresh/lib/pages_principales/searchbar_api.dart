import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/searchbar_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

DatabaseHelper dbHelper = DatabaseHelper();

Future<void> fetchAndStoreProducts() async {
  final response = await http.get(Uri.parse(
      '${api_link}/api_fresh/allproducts.php')); // Remplace l'URL par ton API

  if (response.statusCode == 200) {
    List<dynamic> products = json.decode(response.body);
    print(json.decode(response.body));

    // Insérer chaque produit dans SQLite
    for (var product in products) {
      await dbHelper.insertProduct(
        product['id'], //?? 0, // par défaut 0 si null
        product['nom'],// ?? 'Dorade', // string par défaut
        product['prix']
        //(product['price'] ?? 2000).toDouble(), // 0.0 si null
      );
    }

    print("Produits enregistrés localement !");
  } else {
    throw Exception('Erreur lors du chargement des produits');
  }
}
