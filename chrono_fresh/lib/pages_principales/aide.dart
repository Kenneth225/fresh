import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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




void openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
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
                    buildListTile('Politique de protection des données', () {
                    openUrl('https://www.squirrel.fr/mentions-legales-application-mobile-exemple/');

                    }),
                    const Divider(),
                    buildListTile("Conditions générales d’utilisation", () {
                    openUrl('https://www.squirrel.fr/mentions-legales-application-mobile-exemple/');

                    }),
                    const Divider(),
                    buildListTile('Mentions légales', () {
                      openUrl('https://flutter.dev');

                    }),
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

                    
                  ])),
        ));
  }
}

    