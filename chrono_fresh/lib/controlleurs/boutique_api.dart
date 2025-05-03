import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/boutique_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Boutique>>  viewboutique(name) async {

  var url = Uri.parse("${api_link}/api_fresh/maboutique.php");
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