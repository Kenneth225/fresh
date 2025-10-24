import 'dart:io';

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
  String? _imagePath;
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
        _imagePath = prefs.getString('user_image');
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
/*
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
  }*/

  void logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Fluttertoast.showToast(msg: "Déconnexion", toastLength: Toast.LENGTH_SHORT);

    Navigator.of(context).pushNamedAndRemoveUntil(
      'home',
      (route) => false,
    );
    print("Done");
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vous allez être déconnecté de votre profil CHRONOFRESH'),
                Text('Poursuivre cette action:'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("NON"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OUI"),
              onPressed: () {
                logout(context);
              },
            ),
          ],
        );
      },
    );
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
      msg: "Faite un appui long pour vous deconnecté",
    );
    print(role);
  }

  /*void info1(context) async {
    Fluttertoast.showToast(
        msg: "Tapez deux fois pour vous Connecté",
        toastLength: Toast.LENGTH_SHORT);
    print("Done");
  }*/

  Widget buildListTile(IconData icon, String title, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green), // icône à gauche
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 16, color: Colors.grey), // icône de flèche
      onTap: () => onTap(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoggedIn
          ? Center(
              child: role == "2"
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _imagePath != null
                                      ? FileImage(File(_imagePath!))
                                      : null,
                                  child: _imagePath == null
                                      ? const Icon(Icons.person, size: 50)
                                      : null,
                                ),
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
                  :
                  // Définir une fonction pour créer un widget de ligne pour la liste
// Le corps de la page
// Nous utiliserons un Stack pour superposer les widgets
                  Center(
                      child: Container(
                        width: double.infinity,
                        child: SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      // En-tête de la page ("Mon compte")
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 20.0, bottom: 15.0),
                                        child: Text(
                                          'Mon compte',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      // Section du profil utilisateur
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: _imagePath !=
                                                      null
                                                  ? FileImage(File(_imagePath!))
                                                  : null,
                                              child: _imagePath == null
                                                  ? const Icon(Icons.person,
                                                      size: 50)
                                                  : null,
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "$prenom $nom",
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "$mail",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Divider(),

                                      // Liste des options
                                      buildListTile(
                                          Icons.folder_open, 'Mes commandes',
                                          () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Mescommandes(id: "$id")));
                                      }),
                                      const Divider(),
                                      buildListTile(Icons.person_outline,
                                          'Mes informations personnelles', () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PersonalInfoPage()));
                                      }),
                                      const Divider(),
                                      buildListTile(Icons.location_on_outlined,
                                          'Mon adresses de livraison', () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FavoriteAddressesPage()));
                                      }),
                                      const Divider(),
                                      buildListTile(
                                          Icons.info_outline, 'À propos', () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelpPage()));
                                      }),
                                      const Divider(),
                                    ],
                                  ),

                                  // Bouton de déconnexion
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/fresh.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          _showMyDialog();
                                        },
                                        icon: const Icon(Icons.logout,
                                            color: Colors.white),
                                        label: const Text(
                                          'Me déconnecter',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[800],
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          minimumSize: const Size(
                                              double.infinity,
                                              50), // largeur adaptative
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

              /* Column(
                      children: [
                        Column(
                          children: [
                            // En-tête de la page ("Mon compte")
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                              child: Text(
                                'Mon compte',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Section du profil utilisateur
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 20.0),
                              child: Row(
                                children: [
                                  Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  _imagePath != null ? FileImage(File(_imagePath!)) : null,
                              child: _imagePath == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "$prenom $nom",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "$mail",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Divider(), // Ligne de séparation

                            // Liste des options
                            buildListTile(Icons.folder_open, 'Mes commandes',
                                () {
                              Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Mescommandes(
                                                    id: "${id}",
                                                  )));
                            }),
                            const Divider(),
                            buildListTile(Icons.person_outline,
                                'Mes informations personnelles', () {
                              Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonalInfoPage()));
                            }),
                            const Divider(),
                            buildListTile(Icons.location_on_outlined,
                                'Mon adresses de livraison', () {
                              Navigator.of(context).push(
                              MaterialPageRoute(
                                              builder: (context) =>
                                                  const FavoriteAddressesPage()));
                            }),
                            const Divider(),
                            buildListTile(Icons.info_outline, 'À propos', () {
                           Navigator.of(context).push(   MaterialPageRoute(
                                              builder: (context) =>
                                                  const HelpPage()));
                            }),
                            const Divider(),
                          ],
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              // 1. Image de fond qui couvre toute la hauteur disponible
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/fresh.png', // Remplacez par le chemin de votre image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // 2. Contenu principal de la page, enveloppé dans un SingleChildScrollView
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Bouton de déconnexion
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                                                                                    
                                           _showMyDialog();
                                          // Logique de déconnexion
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[
                                              800], // Couleur de fond du bouton
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // Bords arrondis
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15),
                                          minimumSize: const Size(double.infinity,
                                              50), // S'étend sur toute la largeur
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // La Row ne prend pas toute la largeur
                                          children: [
                                            Icon(Icons.logout,
                                                color: Colors
                                                    .white), // Icône de déconnexion
                                            SizedBox(width: 10),
                                            Text(
                                              'Me déconnecter',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )*/
              /*Column(
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
                    ),*/
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
