import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/categorie_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Categorie>>  viewcatall() async {

  var url = Uri.parse("${api_link}/api_fresh/allcategories.php");
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