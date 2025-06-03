import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:chrono_fresh/controlleurs/course_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/course_structure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  String? id;
  int _step = 0;
  double _distanceToClient = 3.5; // Simulation

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
    });
  }

  Future<void> _startCourse(idS, sp) async {
    print(idS);
    print(sp);
    var url = Uri.parse("${api_link}/api_fresh/updatecourse.php");
    var data = {"idR": idS, "sp": sp};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Course lancée", toastLength: Toast.LENGTH_LONG);
      setState(() {
        _step = 1;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  

  Future<void> _markArrival(idS, sp) async {
    var url = Uri.parse("${api_link}/api_fresh/updatecourse.php");
    var data = {"idR": idS, "sp": sp};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Course Terminé", toastLength: Toast.LENGTH_LONG);
      setState(() {
        _step = 2;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  Widget _buildStep(String title, IconData icon, bool active) {
    return Row(
      children: [
        Icon(icon, color: active ? Colors.green : Colors.grey, size: 28),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.grey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(x, y) {
    if (_step == 0) {
      return ElevatedButton(
        onPressed: () {
          _startCourse(x, 'demmarrer');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Démarrer la course", style: TextStyle(fontSize: 16)),
      );
    } else if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Livraison en cours...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            "Distance au client : $_distanceToClient km",
            style: TextStyle(fontSize: 16, color: Colors.orange[700]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () { 
              _markArrival(x, 'fin');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Marquer mon arrivée", style: TextStyle(fontSize: 16)),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const Icon(Icons.check_circle, size: 80, color: Colors.green),
          const SizedBox(height: 10),
          const Text("Arrivée marquée avec succès !",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const Text("Faite sanné ce QR code par le client pour validé la livraison !",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
              QrImageView(
              data: y,
              version: QrVersions.auto,
              size: 200.0,
            )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Suivi de livraison"),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: getCourseDetails(id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Aucune livraison en cours'));
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return const Center(child: Text('Aucune livraison en cours'));
              } else {
                final List course = snapshot.data;
                return ListView.builder(
                  itemCount: course.length,
                  itemBuilder: (BuildContext context, int index) {
                    final mc = course[index] as Course;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStep("1. Démarrer la course",
                            Icons.directions_run, _step >= 0),
                        SizedBox(height: 12),
                        _buildStep("2. Livraison en cours",
                            Icons.local_shipping, _step >= 1),
                        SizedBox(height: 12),
                        _buildStep(
                            "3. Marquer mon arrivée", Icons.flag, _step >= 2),
                        Divider(height: 40),
                        Center(child: _buildContent(mc.id, mc.test)),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

//permettre de marquer le debut et la fin d'une course
/*Future<void> updatecourse(idC, idU) async {
    var url = Uri.parse("${api_link}/api_fresh/addcourse.php");
    var data = {"idc": idC, "idu": idU};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Merci, Course acceptée",
          toastLength: Toast.LENGTH_LONG);
    }else if (jsonDecode(res.body) == "asaved") {
      Fluttertoast.showToast(
          msg: "Vous avez deja accepté cette course",
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    } 
  }*/
