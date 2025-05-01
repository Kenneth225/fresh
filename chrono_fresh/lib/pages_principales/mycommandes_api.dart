import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/mescommandes_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Mcommande>>  viewsorders(idclt) async {

  var url = Uri.parse("${api_link}/api_fresh/mycommandes.php");
  var data = {
    'idclt': idclt,
  };

  var res = await http.post(url, body: data);
  print("checking..c");
  if (res.statusCode == 200) {
    print(jsonDecode(res.body));
    final data = jsonDecode(res.body);
    print(data);
    
  }
  return mcommandeFromJson(res.body);
}
