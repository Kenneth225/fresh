import 'package:chrono_fresh/pages_principales/mescommandes.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  final String id; // 🔹 On ajoute un paramètre id (puisqu’il est utilisé plus bas)

  const ConfirmationPage({super.key, required this.id});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 🔹 Image en haut
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                "assets/fresh.png", // ton image ici
                height: 250,
                fit: BoxFit.cover,
              ),
            ),

            // 🔹 Texte de confirmation
            const Column(
              children: [
                Text(
                  "Votre commande a bien\nété prise en compte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Un email de confirmation vient\nde vous être envoyé.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            // 🔹 Boutons en bas
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 🔹 Bouton principal
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Action suivre commande
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Mescommandes(
                              id: widget.id, // ✅ on utilise widget.id
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Suivre ma commande",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🔹 Bouton secondaire
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green[700]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Action retour accueil
                        Navigator.pushReplacementNamed(context, 'accueil');
                      },
                      child: Text(
                        "Revenir sur l'accueil",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
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
