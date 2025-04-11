import 'package:chrono_fresh/pages_principales/recette_api.dart';
import 'package:chrono_fresh/pages_principales/recette_structure.dart';
import 'package:flutter/material.dart';

class Recettes extends StatefulWidget {
  const Recettes({super.key});

  @override
  State<Recettes> createState() => _RecettesState();
}

late Future recetteFuture;

viewallrec() async {
  return await viewrec('0');
}

void showRecipeDetails(BuildContext context, titre, description) {
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
                Text(titre,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

class _RecettesState extends State<Recettes> {
  @override
  void initState() {
    super.initState();
    recetteFuture = viewallrec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recettes')),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
                future: viewallrec(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        // final recipe = snapshot.data[index];
                        Mrecettes recette = snapshot.data[index];
                        return GestureDetector(
                          onTap: () => showRecipeDetails(
                              context, recette.nomPlat, recette.description),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Image.asset(recette.image, height: 60),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(recette.nomPlat,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        const SizedBox(height: 5),
                                        Text(recette.ingredient,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        /*const SizedBox(height: 5),
                                        Wrap(
                                          spacing: 5,
                                          children:
                                              recipe['tags'].map<Widget>((tag) {
                                            return Text("#${tag}");
                                          }).toList(),
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
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erreur code',
                          style: TextStyle(color: Colors.black)),
                    );
                  } else {
                    return const Center(
                      child: Text('Aucune recette disponible',
                          style: TextStyle(color: Colors.black)),
                    );
                  }
                }),
          ),
        ));
  }
}
