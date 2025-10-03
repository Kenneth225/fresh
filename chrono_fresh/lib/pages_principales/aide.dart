import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  Widget buildListTile(String title, Function onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          size: 16, color: Colors.grey), // icône de flèche
      onTap: () => onTap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("À propos"),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Chrono Fresh",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Version 1.2.1",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),

                    // Liste des options
                    buildListTile('Politique de protection des données', () {}),
                    const Divider(),
                    buildListTile('Conditions générales d’utilisation', () {}),
                    const Divider(),
                    buildListTile('Mentions légales', () {}),
                    const Divider(),

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
                        ],
                      ),
                    ),

                    // Logo (remplacez par votre asset réel)
                    /* SizedBox(
                height: 300,
                child: Image.asset('assets/logo.png'), // ou NetworkImage si en ligne
              ),
              const SizedBox(height: 20),
              const Text(
                "Chrono Fresh",
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Version 1.0.1",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),*/
                  ])),
        ));
  }
}
