import 'dart:convert';

import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/mycommandes_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrono_fresh/pages_principales/mescommandes_structure.dart';
import 'package:chrono_fresh/pages_principales/suivi_commande.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late Future ordersFuture;
  late bool isLoggedIn;
  String? nom;
  String? id;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
    //ordersFuture = order(widget.id);
  }

  order(id) async {
    return await viewsorders(id);
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');
    String? role = prefs.getString('role');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = role!;
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
      });
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

Future<void> addcourse(idC, idU) async {
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
  }

  Future<void> decline_course(idC, idU, msg) async {
    var url = Uri.parse("${api_link}/api_fresh/addorderavis.php");
    var data = {"idc": idC, "idu": idU, "avis": msg};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Merci, votre avis sera pris en compte",
          toastLength: Toast.LENGTH_LONG);
    } else if (jsonDecode(res.body) == "asaved") {
      Fluttertoast.showToast(
          msg: "Vous avez deja donner votre avis sur cette commande",
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Mes Courses",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.5,
              child: FutureBuilder<dynamic>(
                  future: order(id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Mcommande mcommande = snapshot.data[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/bfull.jpg',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("N° ${mcommande.id}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text("Total : ${mcommande.total} F",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                        const SizedBox(height: 4),
                                        Text(
                                            "${DateTime.parse("${mcommande.dateCommande}")}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          addcourse(mcommande.id, id);
                                        },
                                        child: const Chip(
                                          label: Text("Accepter la course",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          backgroundColor: Colors.orange,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //addcourse(mcommande.id, id);
                                        },
                                        child: const Chip(
                                          label: Text("Refuser la course",
                                              style:
                                                  TextStyle(color: Colors.white)),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Chargement...',
                            style: TextStyle(color: Colors.black)),
                      );
                    }
                  }),
            ),

            

          ),
          Container(
              child: GestureDetector(
                onTap: () {
                  
                },
                child: const Chip(
                                            label: Text("Demarrer la course",
                                                style:
                                                    TextStyle(color: Colors.white)),
                                            backgroundColor: Colors.blueAccent,
                                          ),
              ),
            )
        ],
      ),
    );
  }
}
