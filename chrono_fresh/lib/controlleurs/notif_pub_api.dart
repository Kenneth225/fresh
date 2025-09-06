import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/notifs_pub_structure.dart';
import 'package:http/http.dart' as http;



Future<List<Notifications>>  viewnotif() async {

  var url = Uri.parse("${api_link}/api_fresh/notif.php");
  var data = {
    
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return notificationsFromJson(res.body);
  }