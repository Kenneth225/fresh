import 'dart:convert';
import 'package:chrono_fresh/controlleurs/nbcourse_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/mescommandes_structure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controlleurs/mycommandes_api.dart';

class Statistique extends StatefulWidget {
  const Statistique({super.key});

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  bool isSwitchOn = false;
  int totalLivraisons = 228;

  late Future ordersFuture;
  late bool isLoggedIn;
  String? nom;
  String? id;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? dispo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
  }

  order(id) async {
    return await viewsorders(id);
  }

  nbcourse(id) async {
    return await totalCourseDetails(id);
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');
    String? role = prefs.getString('role');
    dispo = prefs.getString('dispo');
    print(dispo);

    if (usermail != null && dispo != 0) {
      setState(() {
        isLoggedIn = true;
        isSwitchOn = true;
        mail = usermail;
        role = role!;
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
        dispo = prefs.getString('dispo');
      });
    }
  }

  Future<void> addcourse(idC, idU, code) async {
    var url = Uri.parse("${api_link}/api_fresh/addcourse.php");
    var data = {"idc": idC, "idu": idU, "qrc": code};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Merci, Course acceptée", toastLength: Toast.LENGTH_LONG);
      setState(() {
        order(id);
      });
    } else if (jsonDecode(res.body) == "asaved") {
      Fluttertoast.showToast(
          msg: "Vous avez deja accepté cette course",
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        order(id);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
    setState(() {
      order(id);
    });
  }

  Future<void> decline_course(idC, idU, context) async {
    var url = Uri.parse("${api_link}/api_fresh/rejectcourse.php");
    var data = {"idc": idC, "idu": idU};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Merci, commande rejeter", toastLength: Toast.LENGTH_LONG);
      setState(() {
        order(id);
      });

      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> update_status(spec, idU) async {
    var url = Uri.parse("${api_link}/api_fresh/pass_online.php");

    var data = {"sp": spec, "idR": idU};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(msg: "Merci", toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> _showMyDialog(idC, idU) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ATTENTION'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vous vous appretez à refuser une livraison !'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text("Annuler"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Confirmer"),
                  onPressed: () {
                    decline_course(idC, idU, context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suivi des Livraisons'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Disponibilité",
                  style: TextStyle(fontSize: 18),
                ),
                dispo == "1"
                    ? ElevatedButton(
                        onPressed: () async {
                          update_status('false', id);
                          setState(() {
                            isSwitchOn = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 142, 141, 141),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Desactiver",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          update_status('true', id);

                          setState(() {
                            isSwitchOn = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Activer",
                            style: TextStyle(fontSize: 16)),
                      ),
                Switch(
                  value: isSwitchOn,
                  onChanged: (bool value) {},
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                ),
              ],
            ),
            SizedBox(height: 30),
            // Card de livraisons avec icône
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              shadowColor: Colors.grey.shade300,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Row(
                  children: [
                    // Icône de livraison
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.local_shipping,
                        size: 36,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(width: 20),
                    // Texte et total
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total des livraisons',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 5),
                        FutureBuilder<int>(
                          future: totalCourseDetails(id),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Erreur : ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data}', // affichage du nombre
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              );
                            } else {
                              return Text('Aucune donnée');
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Expanded(
              child: FutureBuilder(
                future: order(id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Aucune demande de livraison disponible'));
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return const Center(
                        child: Text('Aucune demande de livraison disponible.'));
                  } else {
                    final List commandes = snapshot.data;
                    return ListView.builder(
                      itemCount: commandes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final mcommande = commandes[index] as Mcommande;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.local_shipping_outlined,
                                        size: 32, color: Colors.orange),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Demande de livraison',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Commission estimée :  ${double.parse(mcommande.total) * 0.1} FCFA',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        addcourse(
                                            mcommande.id, id, mcommande.iduniq);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Accepter"),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showMyDialog(mcommande.id, id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Refuser"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
