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
  String? avatar;
  String? mail;
  String? id;

  @override
void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.getString("usermail");

    setState(() {
     /*id = prefs.getString("userid");
      nom = prefs.getString("username");
      prenom = prefs.getString("userprenom");*/
      mail = prefs.getString("usermail");
      //avatar = prefs.getString("useravatar");
    });
  }

  void logout(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  //Navigator.pushNamedAndRemoveUntil(context, 'accueil', (route) => false);
  Navigator.pushReplacementNamed(context, 'accueil');
  Fluttertoast.showToast(msg: "Deconnexion", toastLength: Toast.LENGTH_SHORT);
  print("Done");
}

void info(context) async {
    Fluttertoast.showToast(msg: "Tapez deux fois pour vous deconnecté", toastLength: Toast.LENGTH_SHORT);
      print("Done");
}


  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(38.0),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage("assets/moon.jpg"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        "Pseudo User",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 30),
                      ),
                     // Text("$mail")
                      Text("email")
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
                  Row(
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
                            fontWeight: FontWeight.normal, fontSize: 22),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
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
                            fontWeight: FontWeight.normal, fontSize: 22),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
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
                    onTap: (){
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
                              fontWeight: FontWeight.normal, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
