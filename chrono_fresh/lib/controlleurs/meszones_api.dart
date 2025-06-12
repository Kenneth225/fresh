import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Zones>>  viewlocation(name) async {

  var url = Uri.parse("${api_link}/api_fresh/meszones.php");
  var data = {
    'idc': name,
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return zonesFromJson(res.body);
  }