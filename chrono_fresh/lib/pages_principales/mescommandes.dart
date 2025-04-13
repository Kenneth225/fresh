import 'dart:convert';
import 'package:chrono_fresh/acceuil.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/profil.dart';
import 'package:http/http.dart' as http;
import 'package:chrono_fresh/pages_principales/mescommandes_api.dart';
import 'package:chrono_fresh/pages_principales/mescommandes_structure.dart';
import 'package:chrono_fresh/pages_principales/suivi_commande.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Mescommandes extends StatefulWidget {
  String? id;
  Mescommandes({
    super.key,
    this.id,
  });

  @override
  State<Mescommandes> createState() => _MescommandesState();
}

class _MescommandesState extends State<Mescommandes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future ordersFuture;
  late bool isLoggedIn;
  String? nom;
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
    ordersFuture = order(widget.id);
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
        //id = prefs.getString('id');
      });
    }
  }

  order(id) async {
    return await viewsorders(id);
  }

  Future<void> saveavis(idC, idU, msg) async {
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

  Future<void> showInformationDialog(BuildContext context, id) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          final TextEditingController _textEditingController =
              TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Donnez votre avis sur cette commande !",
                textAlign: TextAlign.center,
              ),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Champ requis";
                        },
                        decoration: InputDecoration(hintText: "Votre avis"),
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  child: const Text('Envoyer'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveavis(id, widget.id, _textEditingController.text);
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: const Text('Fermer'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Mes Commandes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "December 2024",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),*/
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 1.9,
              child: FutureBuilder<dynamic>(
                  future: order(widget.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
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
                                        'assets/bfull.jpg', // Remplace cette image par la tienne
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
                                    mcommande.statut == "0"
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Suivicommande()));
                                            },
                                            child: const Chip(
                                              label: Text("Suivre la commande",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              backgroundColor: Colors.orange,
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              const Chip(
                                                label: Text("Terminé",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                backgroundColor: Colors.green,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    showInformationDialog(
                                                        context, mcommande.id);
                                                  },
                                                  icon: const Icon(Icons
                                                      .question_mark_rounded))
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Chargement...',
                            style: TextStyle(color: Colors.black)),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
