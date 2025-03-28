import 'package:chrono_fresh/pages_principales/editprofil.dart';
import 'package:chrono_fresh/pages_principales/mescommandes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
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

  void logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    //Navigator.pushNamedAndRemoveUntil(context, 'accueil', (route) => false);
    Navigator.pushReplacementNamed(context, 'home');
    Fluttertoast.showToast(msg: "Deconnexion", toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }

  void logpage(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    //Navigator.pushNamedAndRemoveUntil(context, 'accueil', (route) => false);
    Navigator.pushReplacementNamed(context, 'home');
    //Fluttertoast.showToast(msg: "Deconnexion", toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }

  void info(context) async {
    Fluttertoast.showToast(
        msg: "Tapez deux fois pour vous deconnecté",
        toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }

  void info1(context) async {
    Fluttertoast.showToast(
        msg: "Tapez deux fois pour vous Connecté",
        toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn
          ? Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          maxRadius: 35,
                          backgroundColor: Colors.green,
                          backgroundImage: AssetImage("assets/moon.jpg"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "${nom}  ${prenom}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 30),
                            ),
                            Text("$mail")
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Mescommandes(id: "${id}",)));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mes commandes",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Editprofil()));
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.badge_outlined,
                                size: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mes données",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        const Row(
                          children: [
                            Icon(
                              Icons.person_pin_circle_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Adresse de livraison",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                            ),
                          ],
                        ),
                        /* Divider(),
                  Row(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      Text(
                        "Paiements",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),*/
                        Divider(),
                        Row(
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Code Promo",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_none_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(
                              Icons.help_outline_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Aide",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_sharp,
                              size: 22,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "A propos",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                            ),
                          ],
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            info(context);
                          },
                          onDoubleTap: () {
                            logout(context);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.power_settings_new_outlined,
                                size: 22,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Deconnexion",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: GestureDetector(
                onTap: () {
                  info1(context);
                },
                onDoubleTap: () {
                  logpage(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new_outlined,
                      size: 22,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Se connecté",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
