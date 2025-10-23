import 'package:chrono_fresh/controlleurs/recette_api.dart';
import 'package:chrono_fresh/controlleurs/recette_api_all.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/recette_structure.dart';
import 'package:flutter/material.dart';

class Recettes extends StatefulWidget {
  String? nom;
  String? description;
  String? ingredient;
  String? image;

  Recettes(
      {super.key, this.nom, this.description, this.ingredient, this.image});

  @override
  State<Recettes> createState() => _RecettesState();
}

// Fonction pour récupérer toutes les recettes
Future<List<Mrecettes>> viewallrec() async {
  return await viewrec('0');
}

// Affichage du détail de la recette en bas de l'écran
void showRecipeDetails(
    BuildContext context, String titre, String description, image) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titre,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Image.network(
                "$api_link/api_fresh/uploads/${image}",
                height: 60,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 200,
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

class _RecettesState extends State<Recettes> {
  late Future<List<Mrecettes>> recetteFuture;

  @override
  void initState() {
    super.initState();
    recetteFuture = viewallrec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Stack(
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                child: Image.network(
                  "$link_photo/${widget.image}",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // ICONE RETOUR
              Positioned(
                top: 40, // padding du haut
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.nom}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                      child: Text(
                    "Préparation",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF006650)),
                  )),
                  Text(
                    "${widget.description}",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
