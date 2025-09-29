import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/detailscommande_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Dcom>>  viewsdetorders(idcmd) async {

  var url = Uri.parse("${api_link}/api_fresh/detailscommande.php");
  var data = {
    'idcmd': idcmd,
  };

  var res = await http.post(url, body: data);
  if (res.statusCode == 200) {
    print(jsonDecode(res.body));
    final data = jsonDecode(res.body);
    print(data);
    
  }
  return dcomFromJson(res.body);
}
