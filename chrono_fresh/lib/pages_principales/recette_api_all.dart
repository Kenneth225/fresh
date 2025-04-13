import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/recette_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Mrecettes>>  viewrecall(id) async {

  var url = Uri.parse("${api_link}/api_fresh/recette.php");
  var data = {
     'mrq': id,
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return mrecettesFromJson(res.body);
  }