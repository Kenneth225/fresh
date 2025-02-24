import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/boutique_api.dart';
import 'package:chrono_fresh/pages_principales/boutique_structure.dart';
import 'package:chrono_fresh/pages_principales/categorie_api.dart';
import 'package:chrono_fresh/pages_principales/categorie_structure.dart';
import 'package:chrono_fresh/pages_principales/categories_details.dart';
import 'package:chrono_fresh/pages_principales/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class boutique extends StatefulWidget {
  const boutique({super.key});

  @override
  State<boutique> createState() => _boutiqueState();
}

class _boutiqueState extends State<boutique> {
  late Future boutiqueFuture;
  late Future categorieFuture;
  String categorie = "";

  @override
  void initState() {
    super.initState();
    print("jai ete demarrer");
    boutiqueFuture = boutique("1");
    categorieFuture = homecat();
  }

  boutique(categorie) async {
    return await viewboutique(categorie);
  }

  homecat() async {
    return await viewcat();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(59, 59, 59, 1),
                ),
                Text("Akpakpa, Cotonou")
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {},
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(59, 59, 59, 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Rechercher dans le magasin",
                      fillColor: Colors.white,
                      hoverColor: Colors.white),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(items: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          "assets/slide.jpeg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ], options: CarouselOptions(autoPlay: true)),
                  ]),
            ),
            FutureBuilder(
                future: homecat(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print('yes');
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        Categorie cate = snapshot.data[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    cate.nomCategorie,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Categoriedetails(
                                                    nom: "${cate.nomCategorie}",
                                                    cat: "${cate.id}",
                                                  )));
                                    },
                                    child: const Text(
                                      "Voir tout",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: FutureBuilder<dynamic>(
                                      future: boutique(cate.id),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          return GridView.builder(
                                            itemCount: snapshot.data.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Boutique boutique =
                                                  snapshot.data[index];
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    color: Colors.white,
                                                    child: Container(
                                                      color: Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => Details(
                                                                              id: boutique.id,
                                                                              nom: boutique.nom,
                                                                              prix: boutique.prix,
                                                                              description: boutique.description,
                                                                              categorie: boutique.categorie,
                                                                              image: boutique.image,
                                                                              stock: boutique.stock,
                                                                            )));
                                                              },
                                                              child: ClipRRect(
                                                                child: Image
                                                                    .network(
                                                                  "${api_link}/api_fresh/uploads/${boutique.image}",
                                                                  height: 60,
                                                                  width: 80,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => Details(
                                                                              id: boutique.id,
                                                                              nom: boutique.nom,
                                                                              prix: boutique.prix,
                                                                              description: boutique.description,
                                                                              categorie: boutique.categorie,
                                                                              image: boutique.image,
                                                                              stock: boutique.stock,
                                                                            )));
                                                              },
                                                              child: Text(
                                                                "${boutique.nom}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            Text(
                                                                "${boutique.stock}kg,Prix"),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "${boutique.prix} fcfa"),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(),
                                                                    onPressed:
                                                                        () {},
                                                                    child: const Icon(
                                                                        Icons
                                                                            .add_outlined),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: (1 / 1),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Center(
                                            child: Text('Erreur code',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          );
                                        } else {
                                          return const Center(
                                            child: Text(
                                                'Aucun produit correspondant',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          );
                                        }
                                      }),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const Text("Aucune donnée disponible");
                  }
                }),
            const SizedBox(
              height: 203,
            )
          ],
        ),
      ),
    );
  }
}
