import 'dart:math';
import 'package:chrono_fresh/controlleurs/categoriesall_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/categorie_structure.dart';
import 'package:chrono_fresh/pages_principales/categories_details.dart';
import 'package:chrono_fresh/pages_principales/searchpage.dart';
import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  late Future categorieFuture;

  @override
  void initState() {
    super.initState();
    categorieFuture = homecat();
  }

  homecat() async {
    return await viewcatall();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Barre de recherche
            // ==== HEADER ====
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF006650),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Catégories",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ==== CHAMP DE RECHERCHE ====
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Search()));
                    },
                    child: TextField(
                      enabled: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        hintText: "Rechercher dans le magasin",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white, // ✅ fond blanc
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // ✅ pas de bord gris
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Liste des catégories
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<dynamic>(
                  future: categorieFuture,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Categorie cate = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Categoriedetails(
                                    nom: cate.nomCategorie,
                                    cat: "${cate.id}",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image catégorie
                                  Column(
                                    children: [
                                      Text(
                                        cate.nomCategorie.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF006650),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.network(
                                          "$link_photo/${cate.visuel}",
                                         height: 70,
                                          fit: BoxFit.fitWidth,
                                          
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),

                                  // Nom de la catégorie
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /*Text(
                                        cate.nomCategorie.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color:Color(0xFF006650),
                                        ),
                                      ),*/
                                        const SizedBox(height: 4),
                                        Text(
                                          cate.nomCategorie,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Flèche
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Aucune donnée disponible',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    /* Scaffold(
       backgroundColor: Colors.white,
        appBar: AppBar( 
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(child: const Text("Catégories")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Search()));
                  },
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
                                    cate.nomCategorie,
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
        ));*/
  }
}
