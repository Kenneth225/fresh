import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/course_structure.dart';
import 'package:http/http.dart' as http;


Future<List<Course>> getCourseDetails(id) async {

  var url = Uri.parse("${api_link}/api_fresh/suivicourse.php");
  var data = {
    'idL': id,
  };

  var res = await http.post(url, body: data);
  print("checking...");
  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    print(data);
  }
  return courseFromJson(res.body);
  }