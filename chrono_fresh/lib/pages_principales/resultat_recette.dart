import 'package:chrono_fresh/controlleurs/recette_api_all.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/recette_structure.dart';
import 'package:chrono_fresh/pages_principales/recettes.dart';
import 'package:flutter/material.dart';

class ReSultatsCateGorieRecette extends StatefulWidget {
  const ReSultatsCateGorieRecette({super.key});
  @override
  ReSultatsCateGorieRecetteState createState() =>
      ReSultatsCateGorieRecetteState();
}

// Fonction pour récupérer toutes les recettes
Future<List<Mrecettes>> viewallrec() async {
  return await viewrecall();
}

class ReSultatsCateGorieRecetteState extends State<ReSultatsCateGorieRecette> {
  late Future<List<Mrecettes>> recetteFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recetteFuture = viewallrec();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Color(0xFFFFFFFF),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      "assets/recettepg.jpg",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.black
                        .withOpacity(0.3), // effet foncé sur l’image
                    width: double.infinity,
                    height: 200,
                  ),
                  const Text(
                    "Les recettes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: Container(
                      color: Color(0xFFFFFFFF),
                      width: double.infinity,
                      //height: double.infinity,
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                           
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 8, left: 20),
                              child: const Text(
                                "Recettes disponibles",
                                style: TextStyle(
                                  color: Color(0xFF7C7C7C),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            FutureBuilder<List<Mrecettes>>(
                                future: recetteFuture,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Mrecettes>> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                          'Erreur lors du chargement des données',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('Aucune recette disponible',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    );
                                  }

                                  final recettes = snapshot.data!;
                                  return SizedBox(
                                    height: 450,
                                    child: ListView.builder(
                                        itemCount: recettes.length,
                                        padding: const EdgeInsets.all(6.0),
                                        itemBuilder: (context, index) {
                                          final recette = recettes[index];
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Recettes(
                                                              nom: recette
                                                                  .nomPlat,
                                                              description: recette
                                                                  .description,
                                                              image:
                                                                  recette.image,
                                                            )));
                                              },
                                              
                                              child: IntrinsicHeight(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 24,
                                                              left: 20,
                                                              right: 20),
                                                      width: double.infinity,
                                                      child: Row( crossAxisAlignment: CrossAxisAlignment .start,
                                                          children: [
                                                            Container( 
                                                              
                                                              margin:const EdgeInsets .only(right: 8),
                                                             width: 100,
                                                              height: 97,
                                                              child:
                                                                  Image.network(
                                                                "$link_photo/${recette.image}",
                                                                height: 60,
                                                                width: 90,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: IntrinsicHeight(
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                          IntrinsicWidth(
                                                                            child:
                                                                                IntrinsicHeight(
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(bottom: 12),
                                                                                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  IntrinsicWidth(
                                                                                    child: IntrinsicHeight(
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(64),
                                                                                          color: Color(0x33006650),
                                                                                        ),
                                                                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                                                                        margin: const EdgeInsets.only(right: 8),
                                                                                        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                          Text(
                                                                                            "Recette",
                                                                                            style: TextStyle(
                                                                                              color: Color(0xFF000000),
                                                                                              fontSize: 13,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ]),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  IntrinsicWidth(
                                                                                    child: IntrinsicHeight(
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(64),
                                                                                          color: Color(0x33006650),
                                                                                        ),
                                                                                        padding: const EdgeInsets.only(left: 8, right: 8),
                                                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                          Text(
                                                                                            recette.ingredient,
                                                                                            style: const TextStyle(
                                                                                              color: Color(0xFF000000),
                                                                                              fontSize: 13,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ]),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          IntrinsicHeight(
                                                                              child: Container(
                                                                                  width: double.infinity,
                                                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                    Container(margin: const EdgeInsets.only(bottom: 6), child: Text(recette.nomPlat, style: const TextStyle(color: Color(0xFF000000), fontSize: 13, fontWeight: FontWeight.bold)))
                                                                                  ])))
                                                                        ]))))
                                                          ]))));
                                        }),
                                  );
                                })
                          ]))))
            ])));
  }
}
