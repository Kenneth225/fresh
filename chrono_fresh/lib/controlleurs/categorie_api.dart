import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/categorie_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Categorie>>  viewcat() async {

  var url = Uri.parse("${api_link}/api_fresh/mescategorieshome.php");
  var data = {
    
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return categorieFromJson(res.body);
  }