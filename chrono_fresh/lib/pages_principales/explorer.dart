import 'dart:math';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/categorie_api.dart';
import 'package:chrono_fresh/pages_principales/categorie_structure.dart';
import 'package:chrono_fresh/pages_principales/categories_details.dart';
import 'package:chrono_fresh/pages_principales/categoriesall_api.dart';
import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

const List<Map<String, String>> categories = [
  {'title': 'Poissons fraîches', 'image': 'assets/fish.png'},
  {'title': 'Viandes', 'image': 'assets/viande.jpeg'},
  {'title': 'Viandes et poissons', 'image': 'assets/melange.png'},
  {'title': 'Viande rouge', 'image': 'assets/board.png'},
];

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(200) + 50,
    random.nextInt(200) + 50,
    random.nextInt(200) + 50,
  ).withOpacity(0.2);
}

class _ExplorerState extends State<Explorer> {
  late Future categorieFuture;

  @override
  void initState() {
    categorieFuture = homecat();
  }

  homecat() async {
    return await viewcatall();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(child: const Text("Trouver des produits")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher dans le magasin',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<dynamic>(
                  future: homecat(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Categorie cate = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Categoriedetails(
                                                    nom: "${cate.nomCategorie}",
                                                    cat: "${cate.id}",
                                                  )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: getRandomColor(),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "${api_link}/api_fresh/uploads/${cate.visuel}",
                                    height: 60,
                                    // width: 80,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    cate.nomCategorie!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Aucun produit correspondant',
                            style: TextStyle(color: Colors.black)),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
