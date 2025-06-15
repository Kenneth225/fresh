import 'dart:convert';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
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
  bool load = false;

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
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Or other accuracy levels
      );
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      print(idS);
      print(sp);
      var url = Uri.parse("${api_link}/api_fresh/updatecourse.php");
      var data = {
        "idR": idS,
        "sp": sp,
        "lat": "${position.latitude}",
        "long": "${position.longitude}"
      };
      var res = await http.post(url, body: data);

      if (jsonDecode(res.body) == "true") {
        Fluttertoast.showToast(
            msg: "Course lancée", toastLength: Toast.LENGTH_LONG);
        setState(() {
          _step = 1;
          load = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print('Error getting current position: $e');
      // Handle errors (e.g., location permission denied)
      /* setState(() {
        load = false;
      });*/
    }
  }

  double _toRad(double deg) => deg * pi / 180;

  double calculateDistanceInKm(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Rayon de la Terre en km
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);

    final lat1Rad = _toRad(lat1);
    final lat2Rad = _toRad(lat2);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

    return R * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  Future<void> _markArrival(idS, sp) async {
    if (calculateDistanceInKm == 1.0) {
      Fluttertoast.showToast(
          msg: "vous n'etes pas tres proche du client",
          toastLength: Toast.LENGTH_LONG);
    } else {
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

  Widget _buildContent(x, y, long1, lat1, long2, lat2) {
    if (_step == 0) {
      return load
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                _startCourse(x, 'demmarrer');
                setState(() {
                  load = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Démarrer la course",
                  style: TextStyle(fontSize: 16)),
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
            "Distance au client : ${calculateDistanceInKm(double.parse(lat1), double.parse(long1), double.parse(lat2), double.parse(long2))} km",

            //
            //${calculateDistanceInKm(double.parse(lat1), double.parse(long1), double.parse(lat2), double.parse(long2))}
            style: TextStyle(fontSize: 16, color: Colors.orange[700]),
          ),
          const SizedBox(height: 20),
          load
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    _markArrival(x, 'fin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Marquer mon arrivée",
                      style: TextStyle(fontSize: 16)),
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
          const Text(
              "Faite sanné ce QR code par le client pour validé la livraison !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 10),
          QrImageView(
            data: y,
            version: QrVersions.auto,
            size: 200.0,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _step = 0;
                });
              },
              child: const Text('test'))
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
                            Icons.directions_run, _step == 0),
                        SizedBox(height: 12),
                        _buildStep("2. Livraison en cours",
                            Icons.local_shipping, _step == 1),
                        SizedBox(height: 12),
                        _buildStep(
                            "3. Marquer mon arrivé", Icons.flag, _step == 2),
                        Divider(height: 40),
                        Center(
                            child: _buildContent(mc.id, mc.test, mc.longc,
                                mc.latc, mc.longitude, mc.latitude)),
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
