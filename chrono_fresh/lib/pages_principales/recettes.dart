import 'package:chrono_fresh/controlleurs/recette_api_all.dart';
import 'package:chrono_fresh/models/recette_structure.dart';
import 'package:flutter/material.dart';

class Recettes extends StatefulWidget {
  const Recettes({super.key});

  @override
  State<Recettes> createState() => _RecettesState();
}

// Fonction pour récupérer toutes les recettes
Future<List<Mrecettes>> viewallrec() async {
  return await viewrecall('0');
}

// Affichage du détail de la recette en bas de l'écran
void showRecipeDetails(BuildContext context, String titre, String description) {
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
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
       backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Recettes')),
      body: FutureBuilder<List<Mrecettes>>(
        future: recetteFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Mrecettes>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors du chargement des données',
                  style: TextStyle(color: Colors.black)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucune recette disponible',
                  style: TextStyle(color: Colors.black)),
            );
          }

          final recettes = snapshot.data!;
          return ListView.builder(
            itemCount: recettes.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final recette = recettes[index];
              return GestureDetector(
                onTap: () => showRecipeDetails(
                  context,
                  recette.nomPlat,
                  recette.description,
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          recette.image,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recette.nomPlat,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            /*  const SizedBox(height: 5),
                              Text(
                                recette.ingredient,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
