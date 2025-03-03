import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class connection extends StatefulWidget {
  const connection({super.key});

  @override
  State<connection> createState() => _connectionState();
}

class _connectionState extends State<connection> {
  late TextEditingController numctrl;
  late TextEditingController mailctrl;
  bool have_acount = true;

  @override
  void initState() {
    super.initState();
    numctrl = TextEditingController();
    mailctrl = TextEditingController();
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
                child:
                    /*PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context,
                        length: 6,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                          //  code = value;
                          });
                        }),*/
                    TextField(
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
      if (jsonDecode(res.body) == "true") {
        print("inscription");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('usermail', mail);
     
        Navigator.pushReplacementNamed(context, 'accueil');
      } else {
        Fluttertoast.showToast(
            msg: "Erreur de connexion", toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
               gradient: LinearGradient(colors: [
                          Color.fromRGBO(208, 208, 208, 0.667),
                          Color.fromRGBO(60, 60, 60, 1),
                        ]),
              image: DecorationImage(
                opacity: 10,
                  image: AssetImage("assets/roast_chicken.jpg"), fit: BoxFit.cover)),
                child: Image.asset(
                  "assets/roast_chicken.jpg",
                  height: 325,
                  width: 125,
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              const Text("Faites vos courses avec Chrono Fresh", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 29,
                                  ),),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Avez vous un compte ?", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  Switch(
                    // This bool value toggles the switch.
                    value: have_acount,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        have_acount = value;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: have_acount
                    ? Column(children: [
                        TextField(
                          controller: mailctrl,
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
                      ])
                    : Column(
                        children: [
                          TextField(
                            // controller: ,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Entrez votre Nom",
                                fillColor: Colors.white,
                                hoverColor: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            // controller: ,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                //filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Entrez votre Prenom",
                                fillColor: Colors.white,
                                hoverColor: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            // controller: ,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                //filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Entrez votre adresse Mail",
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
                                    //Navigator.pushReplacementNamed(context, 'connect');
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
                        ],
                      ),
              )
            ],
          ),
      ),
      
    );
  }
}
