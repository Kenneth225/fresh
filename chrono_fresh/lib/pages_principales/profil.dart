import 'package:chrono_fresh/pages_principales/aide.dart';
import 'package:chrono_fresh/pages_principales/conditions.dart';
import 'package:chrono_fresh/pages_principales/editprofil.dart';
import 'package:chrono_fresh/pages_principales/favorite_adress.dart';
import 'package:chrono_fresh/pages_principales/mescommandes.dart';
import 'package:chrono_fresh/pages_principales/notifications.dart';
import 'package:flutter/material.dart';
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
    final String? coderole = prefs.getString('role');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = coderole;
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
    /*  Navigator.of(context).pushNamedAndRemoveUntil(
      'home',
      (route) => false,
    );*/

    Fluttertoast.showToast(msg: "Deconnexion", toastLength: Toast.LENGTH_SHORT);

    Navigator.pushReplacementNamed(context, 'home');
    print("Done");
  }

  void logpage(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      'home',
      (route) => false,
    );

    print("Done");
  }

  void info(context) async {
    Fluttertoast.showToast(
        msg: "Faite un appui long pour vous deconnecté",);
    print(role);
  }

  /*void info1(context) async {
    Fluttertoast.showToast(
        msg: "Tapez deux fois pour vous Connecté",
        toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoggedIn
          ? Center(
              child: role == "1"
                  ? Column(
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
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30),
                                  ),
                                  Text("$mail")
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Mescommandes(
                                                    id: "${id}",
                                                  )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.shopping_bag_outlined,
                                              size: 25,
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Mes Commandes",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonalInfoPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Column(children: [
                                          Icon(
                                            Icons.badge_outlined,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Mes Données",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FavoriteAddressesPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Icon(
                                            Icons.person_pin_circle_outlined,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Adresses de livraison",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(11.5),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.notifications_none_outlined,
                                              size: 25,
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Notifications",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CguPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(children: [
                                          Icon(
                                            Icons.warning_amber_sharp,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Conditions",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HelpPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),*/
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.help_outline_outlined,
                                                size: 25,
                                              ),
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "A propos",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  info(context);
                                },
                                onLongPress: () {
                                  logout(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.output_rounded,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    Text("Deconnexion",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
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
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30),
                                  ),
                                  Text("$mail")
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonalInfoPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Column(children: [
                                          Icon(
                                            Icons.badge_outlined,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Mes Données",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(11.5),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.notifications_none_outlined,
                                              size: 25,
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Notifications",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CguPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(children: [
                                          Icon(
                                            Icons.warning_amber_sharp,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Conditions",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HelpPage()));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),*/
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.help_outline_outlined,
                                                size: 25,
                                              ),
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "A propos",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  info(context);
                                },
                                onLongPress: () {
                                  logout(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.output_rounded,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    Text("Deconnexion",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18)),
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
                  info(context);
                },
                onDoubleTap: () {
                  logpage(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new_outlined,
                      size: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Se connecté",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
