import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:chrono_fresh/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  late TextEditingController nomctrl;
  late TextEditingController prenomctrl;
  late TextEditingController mailctrl;
  late TextEditingController numctrl;
  bool have_acount = true;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    nomctrl = TextEditingController();
    prenomctrl = TextEditingController();
    mailctrl = TextEditingController();
    numctrl = TextEditingController();
  }

  void decidor(context, value) {
    if (value == "") {
      Fluttertoast.showToast(
          backgroundColor: Colors.blueAccent,
          msg: "Veuillez saisir un email",
          toastLength: Toast.LENGTH_LONG);
    } else {
      showRecipeDetails(context);
    }
  }

  Future<void> _showMyDialogvalidation(mail, cd) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('VERIFICATION DE MAIL'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Un e-mail de confirmation vous a été envoyé. Cliquez sur le lien pour continuer. Pensez à vérifier vos spams !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                getcode(mail, cd);
              },
            ),
          ],
        );
      },
    );
  }

  void showRecipeDetails(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      //isDismissible: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text("Entrez le code à 5 chiffres reçu par mail")),
              const SizedBox(
                height: 10,
              ),
              const Text("Code"),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: TextField(
                  controller: numctrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "-   -   -   -   -"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Renvoyer le code"),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login(mailctrl.text, numctrl.text);
                    },
                    child: const Text('Valider'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> login(mail, code) async {
    print("start ${mail} et ${code}");
    if (code != "02025") {
      Fluttertoast.showToast(
          msg: "Code incorrect", toastLength: Toast.LENGTH_SHORT);
    } else {
      var url = Uri.parse("${api_link}/api_fresh/inscorp.php");
      var data = {"mail": mail, "code": code};

      var res = await http.post(url, body: data);

      if (jsonDecode(res.body) != "pas de compte") {
        var jsonData = jsonDecode(res.body);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
       // if (jsonData[0]["role"] != "2") {
          if (jsonData[0]["telephone"] != null) {
            prefs.setString('role', jsonData[0]["role"]);
            prefs.setString('email', jsonData[0]["email"]);
            prefs.setString('nom', jsonData[0]["nom"]);
            prefs.setString('prenom', jsonData[0]["prenom"]);
            prefs.setString('telephone', jsonData[0]["telephone"]);
            prefs.setString('id', jsonData[0]["id"]);
          } else {
            prefs.setString('role', jsonData[0]["role"]);
            prefs.setString('email', jsonData[0]["email"]);
            prefs.setString('nom', jsonData[0]["nom"]);
            prefs.setString('prenom', jsonData[0]["prenom"]);
            prefs.setString('telephone', "...");
            prefs.setString('id', jsonData[0]["id"]);
          }
      /*  } else {
          prefs.setString('dispo', jsonData[0]["statutDisponibilite"]);
          prefs.setString('role', jsonData[0]["role"]);
          prefs.setString('email', jsonData[0]["email"]);
          prefs.setString('nom', jsonData[0]["nom"]);
          prefs.setString('prenom', jsonData[0]["prenom"]);
          prefs.setString('telephone', jsonData[0]["telephone"]);
          prefs.setString('id', jsonData[0]["id"]);
        }*/

        setState(() {
          isLoggedIn = true;
        });

        Navigator.pushReplacementNamed(context, 'accueil');
      } else {
        Fluttertoast.showToast(
            msg: "Le mail inscrit n'existe pas dans nos donnés",
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  Future<void> saveuser(nom, prenom, mail) async {
    var rng = new Random();
    var next = rng.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    var cd = rng.nextInt(900100);
    print(cd);

    var url = Uri.parse("${api_link}/api_fresh/inscrip.php");
    var data = {"nom": nom, "prenom": prenom, "mail": mail, "key": '${cd}'};
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      _showMyDialogvalidation(mail, cd);
    } else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
  }

  void getcode(mail, value) async {
    if (value != '......') {
      var url = Uri.parse("${api_link}/api_fresh/checkcode.php");
      var data = {"mail": mail, "key": '${value}'};

      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) != "pas de compte") {
        var jsonData = jsonDecode(res.body);
        print(jsonData);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (jsonData[0]["telephone"] != null) {
          prefs.setString('role', jsonData[0]["role"]);
          prefs.setString('email', jsonData[0]["email"]);
          prefs.setString('nom', jsonData[0]["nom"]);
          prefs.setString('prenom', jsonData[0]["prenom"]);
          prefs.setString('telephone', jsonData[0]["telephone"]);
          prefs.setString('id', jsonData[0]["id"]);
        } else {
          prefs.setString('role', jsonData[0]["role"]);
          prefs.setString('email', jsonData[0]["email"]);
          prefs.setString('nom', jsonData[0]["nom"]);
          prefs.setString('prenom', jsonData[0]["prenom"]);
          prefs.setString('telephone', "...");
          prefs.setString('id', jsonData[0]["id"]);
        }

        setState(() {
          isLoggedIn = true;
        });

        Navigator.pushReplacementNamed(context, 'accueil');
      } else {
        print("pas de compte");
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, 'accueil', (route) => false);
      Fluttertoast.showToast(msg: "PROBLEME", toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/roast_chicken.jpg",
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: have_acount
                  ? Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.2,
                      ),
                      const Text(
                        "Faites vos courses avec Chrono Fresh",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Connexion",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextField(
                        controller: mailctrl,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            //filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Entrez votre adresse mail",
                            fillColor: Colors.white,
                            hoverColor: Colors.white),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Container(
                          height: 55,
                          //width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(14, 209, 223, 0.667),
                                Color.fromRGBO(87, 118, 192, 1),
                              ])),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                decidor(context, mailctrl.text);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Se connecté",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Pas encore de compte ?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                have_acount = !have_acount;
                              });
                            },
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ])
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.2,
                          ),
                          const Text(
                            "Faites vos courses avec Chrono Fresh",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Inscription",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextField(
                            controller: nomctrl,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Nom",
                                fillColor: Colors.white,
                                hoverColor: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: prenomctrl,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                //filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Prenom",
                                fillColor: Colors.white,
                                hoverColor: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: mailctrl,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                //filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Mail",
                                fillColor: Colors.white,
                                hoverColor: Colors.white),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Container(
                              height: 55,
                              //width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(14, 209, 223, 0.667),
                                    Color.fromRGBO(87, 118, 192, 1),
                                  ])),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    saveuser(nomctrl.text, prenomctrl.text,
                                        mailctrl.text);
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "S'inscrire",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Vous avez deja un compte ?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    have_acount = !have_acount;
                                  });
                                },
                                child: const Text(
                                  "Se connecté",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
