import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
                      Text("Email User")
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
