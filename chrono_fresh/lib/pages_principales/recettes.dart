import 'package:chrono_fresh/pages_principales/recette_api.dart';
import 'package:chrono_fresh/pages_principales/recette_structure.dart';
import 'package:flutter/material.dart';

class Recettes extends StatefulWidget {
  const Recettes({super.key});

  @override
  State<Recettes> createState() => _RecettesState();
}

const List<Map<String, dynamic>> recipes = [
  {
    'title': 'Salade de saumon',
    'image': 'assets/salmon_salad.jpeg',
    'tags': ['Saumon', 'Légumes', 'Healthy'],
    'description':
        'Une délicieuse salade avec du saumon frais, des légumes croquants et une vinaigrette maison.'
  },
  {
    'title': 'Poulet rôti',
    'image': 'assets/roast_chicken.jpg',
    'tags': ['Poulet', 'Four', 'Épices'],
    'description':
        'Un poulet rôti tendre et juteux, assaisonné avec des herbes et des épices.'
  },
  {
    'title': 'Pâtes aux crevettes',
    'image': 'assets/shrimp_pasta.jpg',
    'tags': ['Pâtes', 'Crevettes', 'Crème'],
    'description':
        'Des pâtes crémeuses aux crevettes, ail et parmesan pour un goût irrésistible.'
  }
];

void showRecipeDetails(BuildContext context, Map<String, dynamic> recipe) {
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
            Text(recipe['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(recipe['description'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            )
          ],
        ),
      );
    },
  );
}

class _RecettesState extends State<Recettes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Recettes')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<dynamic>(
              future: viewrec('4'),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      Mrecettes recette = snapshot.data[index];
                      return GestureDetector(
                        onTap: () => showRecipeDetails(context, recipe),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Image.asset(recipe['image'], height: 60),
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
                                      const SizedBox(height: 5),
                                      Wrap(
                                        spacing: 5,
                                        children:
                                            recipe['tags'].map<Widget>((tag) {
                                          return Text("#${tag}");
                                        }).toList(),
                                      ),
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
                    child: Text('Aucun produit correspondant',
                        style: TextStyle(color: Colors.black)),
                  );
                }
              }),
        ));
  }
}
