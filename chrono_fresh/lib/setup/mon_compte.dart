import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({super.key});
  @override
  MonCompteState createState() => MonCompteState();
}

class MonCompteState extends State<MonCompte> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                constraints: const BoxConstraints.expand(),
                color: Color(0xFFFFFFFF),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              color: Color(0xFFFCFCFC),
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 34, left: 140),
                                      child: Text(
                                        "Mon compte",
                                        style: TextStyle(
                                          color: Color(0xFF181725),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 52, left: 25),
                                          child: Row(children: [
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 20),
                                                width: 63,
                                                height: 64,
                                                child: Image.network(
                                                  "https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ZHnJsOCkm0/12qdza15_expires_30_days.png",
                                                  fit: BoxFit.fill,
                                                )),
                                            IntrinsicWidth(
                                              child: IntrinsicHeight(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      IntrinsicWidth(
                                                        child: IntrinsicHeight(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 5),
                                                            child: Row(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            36),
                                                                    child: Text(
                                                                      "${nom} ${prenom}",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Color(
                                                                            0xFF181725),
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${mail}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF7C7C7C),
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                        child: Container(
                                            color: Color(0xFFFFFFFF),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: Color(0xFFE2E2E2),
                                                    height: 1,
                                                    width: double.infinity,
                                                    child: SizedBox(),
                                                  ),
                                                  IntrinsicWidth(
                                                    child: IntrinsicHeight(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 27),
                                                        child: const Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .shopping_bag_outlined,
                                                                size: 25,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  "Mes commandes",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF181725),
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ])))
                                  ]))))
                    ]))));
  }
}
