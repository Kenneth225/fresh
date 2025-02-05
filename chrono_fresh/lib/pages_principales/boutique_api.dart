import 'dart:convert';
import 'package:chrono_fresh/pages_principales/boutique_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Boutique>>  viewboutique(name) async {

  var url = Uri.parse("http://10.0.2.2:80/api_fresh/maboutique.php");
  var data = {
    'categorie': name,
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return boutiqueFromJson(res.body);
  }