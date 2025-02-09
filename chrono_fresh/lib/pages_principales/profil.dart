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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                      Icon(Icons.shopping_bag_outlined),
                      Text(
                        "Commandes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.badge_outlined),
                      Text(
                        "Details",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.person_pin_circle_outlined),
                      Text(
                        "Adresse de livraison",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                 /* Divider(),
                  Row(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      Text(
                        "Paiements",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),*/
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.payments_outlined),
                      Text(
                        "Code Promo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.notifications_none_outlined),
                      Text(
                        "Notifications",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.help_outline_outlined),
                      Text(
                        "Aide",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.warning_amber_sharp),
                      Text(
                        "A propos",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
