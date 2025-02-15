import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/boutique_api.dart';
import 'package:chrono_fresh/pages_principales/boutique_structure.dart';
import 'package:chrono_fresh/pages_principales/details.dart';
import 'package:flutter/material.dart';

class boutique extends StatefulWidget {
  const boutique({super.key});

  @override
  State<boutique> createState() => _boutiqueState();
}

class _boutiqueState extends State<boutique> {
  late Future boutiqueFuture;
  String categorie = "";

  @override
  void initState() {
    super.initState();
    print("jai ete demarrer");
    boutiqueFuture = boutique("1");
  }

  boutique(categorie) async {
    return await viewboutique(categorie);
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
            Container(
              child: Padding(
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
                      SizedBox(width: 2,),
                      /*ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          "assets/moon.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),*/
                    ], options: CarouselOptions(autoPlay: true)),
                  ]),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Poisson", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.5,),
                  TextButton(onPressed: (){}, child: Text("Voir tout", style: TextStyle(fontSize: 16, color: Colors.green),)),
                
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: FutureBuilder<dynamic>(
                  future: boutique("1"),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: 2 ,
                        //snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Boutique boutique = snapshot.data[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.black,
                                child: Container(
                                  color: Colors.white,
                                  height: 300,
                                  width: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        id: boutique.id,
                                                        nom: boutique.nom,
                                                        prix: boutique.prix,
                                                        description: boutique
                                                            .description,
                                                        categorie:
                                                            boutique.categorie,
                                                        image: boutique.image,
                                                        stock: boutique.stock,
                                                      )));},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            child: Image.network(
                                              "${api_link}/api_fresh/uploads/${boutique.image}",
                                              height: 60,
                                              width: 80,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        id: boutique.id,
                                                        nom: boutique.nom,
                                                        prix: boutique.prix,
                                                        description: boutique
                                                            .description,
                                                        categorie:
                                                            boutique.categorie,
                                                        image: boutique.image,
                                                        stock: boutique.stock,
                                                      )));
                                            },
                                            child: Text(
                                              "${boutique.nom}",
                                              maxLines: 3,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text("${boutique.stock}kg,Prix"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text("${boutique.prix} fcfa"),
                                            SizedBox(width: 8,),
                                            Container(
                                              /*height: 25,
                                              width: 40,*/
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromRGBO(
                                                            14, 232, 62, 0.667),
                                                        Color.fromRGBO(
                                                            70, 225, 106, 1),
                                                      ])),
                                              child: Center(
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: const Row(
                                                    verticalDirection:
                                                        VerticalDirection.up,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "+",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erreur code',
                            style: TextStyle(color: Colors.black)),
                      );
                    } else {
                      return const Center(
                        child: Text('Aucun Tissu correspondant',
                            style: TextStyle(color: Colors.black)),
                      );
                    }
                  }),
            ),
            SizedBox(height: 2,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Viande", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.5,),
                  TextButton(onPressed: (){}, child: Text("Voir tout", style: TextStyle(fontSize: 16, color: Colors.green),)),
                
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: FutureBuilder<dynamic>(
                  future: boutique("3"),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: 2 ,
                        //snapshot.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Boutique boutique = snapshot.data[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.black,
                                child: Container(
                                  color: Colors.white,
                                  height: 300,
                                  width: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        id: boutique.id,
                                                        nom: boutique.nom,
                                                        prix: boutique.prix,
                                                        description: boutique
                                                            .description,
                                                        categorie:
                                                            boutique.categorie,
                                                        image: boutique.image,
                                                        stock: boutique.stock,
                                                      )));},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            child: Image.network(
                                              "${api_link}/api_fresh/uploads/${boutique.image}",
                                              height: 60,
                                              width: 80,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => Details(
                                                        id: boutique.id,
                                                        nom: boutique.nom,
                                                        prix: boutique.prix,
                                                        description: boutique
                                                            .description,
                                                        categorie:
                                                            boutique.categorie,
                                                        image: boutique.image,
                                                        stock: boutique.stock,
                                                      )));
                                            },
                                            child: Text(
                                              "${boutique.nom}",
                                              maxLines: 3,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text("${boutique.stock}kg,Prix"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text("${boutique.prix} fcfa"),
                                            SizedBox(width: 8,),
                                            Container(
                                              /*height: 25,
                                              width: 40,*/
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color.fromRGBO(
                                                            14, 232, 62, 0.667),
                                                        Color.fromRGBO(
                                                            70, 225, 106, 1),
                                                      ])),
                                              child: Center(
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: const Row(
                                                    verticalDirection:
                                                        VerticalDirection.up,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "+",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                          crossAxisCount: 2,
                          childAspectRatio: (1 / 1),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erreur code',
                            style: TextStyle(color: Colors.black)),
                      );
                    } else {
                      return const Center(
                        child: Text('Aucun Tissu correspondant',
                            style: TextStyle(color: Colors.black)),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
