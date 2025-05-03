import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/mescommandes_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Mcommande>>  viewsorders(idclt) async {

  var url = Uri.parse("${api_link}/api_fresh/mescommandes.php");
  var data = {
    'idclt': idclt,
  };

  var res = await http.post(url, body: data);
  if (res.statusCode == 200) {
    print(jsonDecode(res.body));
    final data = jsonDecode(res.body);
    print(data);
    
  }
  return mcommandeFromJson(res.body);
}
