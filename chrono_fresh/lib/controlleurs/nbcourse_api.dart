import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:http/http.dart' as http;



  Future<int> totalCourseDetails(id) async {
  final response = await http.post(
    Uri.parse('${api_link}/api_fresh/totalcourse.php'),
    body: {'idu': id},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return int.parse(data.toString()); // conversion explicite
  } else {
    throw Exception('Erreur de chargement');
  }
}
