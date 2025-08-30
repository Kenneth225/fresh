import 'dart:math';
import 'dart:ui';
import 'package:chrono_fresh/controlleurs/sboutique_api.dart';
import 'package:chrono_fresh/controlleurs/scategorie_api.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrono_fresh/controlleurs/boutique_api.dart';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/controlleurs/categorie_api.dart';
import 'package:chrono_fresh/controlleurs/searchbar_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/boutique_structure.dart';
import 'package:chrono_fresh/models/categorie_structure.dart';
import 'package:chrono_fresh/pages_principales/categories_details.dart';
import 'package:chrono_fresh/pages_principales/details.dart';
import 'package:chrono_fresh/pages_principales/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cart/cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:chrono_fresh/global_var.dart';

class boutique extends StatefulWidget {
  const boutique({super.key});

  @override
  State<boutique> createState() => _boutiqueState();
}

class _boutiqueState extends State<boutique> {
  late Future boutiqueFuture;
  late Future categorieFuture;
  String categorie = "";
  late bool isLoggedIn;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;

  @override
  void initState() {
    super.initState();
    getLocation();
    autoLogIn();
    fetchAndStoreProducts();
    boutiqueFuture = boutique("1");
    categorieFuture = homecat();
    boutiqueFuture = sboutique("2");
    categorieFuture = scat();
  }

  var cart = FlutterCart();

  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Acces refusé');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('La permission est refuser de facon permanente');
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    print(position);
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');
    String? role = prefs.getString('role');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = role!;
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
      });
    }
  }

  boutique(categorie) async {
    return await viewboutique(categorie);
  }

  homecat() async {
    return await viewcat();
  }

  scat() async {
    return await viewscat();
  }

  sboutique(categorie) async {
    return await viewspromo(categorie);
  }

  commande_fict(id, nom, image, int qt, prix, mode) async {
    cart.addToCart(
        cartModel: CartModel(
            productId: id,
            productName: nom,
            productImages: [image],
            quantity: 1,
            variants: [
              ProductVariant(price: double.parse(prix)),
            ],
            //discount: double.parse(prix),
            productDetails: mode));
    Provider.of<CartProvider>(context, listen: false).addItem();

    Fluttertoast.showToast(
        msg: "Article ajouté au panier", toastLength: Toast.LENGTH_SHORT);
    print(cart.cartLength);
    print(cart.subtotal);
    print(cart.total);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vous devez vous connecté pour effectué cette action'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Se connecté"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final List<Map<String, String>> sliderData = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRVpVsl8RtO8Pj6kzTsT-3cuabT-IYp5FfOw&s",
      "title": "Viandes fraîches",
      "discount": "Obtenez jusqu'à 40% de réduction"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5_Oj_I2EAsrflzWY2kNHuZ21hqtb1T_8Y4g&s",
      "title": "Fruits bio",
      "discount": "Jusqu'à 30% de réduction"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrcWfCyI0ywqGG7J9r476leb1XqfANgoCC_g&s",
      "title": "Légumes frais",
      "discount": "Offre spéciale 25% de réduction"
    },
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

  String dropdownValue = "...";

  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: SingleChildScrollView(
    child: Column(
      children: [
        // ==== HEADER ====
        Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bonjour $prenom,",
                    style: const TextStyle(
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
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: "Rechercher dans le magasin",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white, // ✅ fond blanc
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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

        const SizedBox(height: 15),

        // ==== CAROUSEL ====
        Center(
          child: CarouselSlider.builder(
            itemCount: sliderData.length,
            options: CarouselOptions(
              height: 100,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            itemBuilder: (context, index, realIndex) {
              final item = sliderData[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    )
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        item['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item['discount']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF006650),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // ==== LISTE DES CATÉGORIES SPECIAL====
        FutureBuilder(
          future: scat(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // ✅ évite double scroll
                itemBuilder: (BuildContext context, index) {
                  Categorie cate = snapshot.data[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cate.nomCategorie,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Categoriedetails(
                                    nom: cate.nomCategorie,
                                    cat: "${cate.id}",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Voir plus",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF006650)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // ==== PRODUITS PAR CATÉGORIE ====
                      SizedBox(
                        height: 200,
                        child: FutureBuilder<dynamic>(
                          future: sboutique(cate.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  Boutique boutique = snapshot.data[index];
                                  return Container(
                                    width: 180,
                                    margin: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image + overlay
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                          id: boutique.id,
                                                          nom: boutique.nom,
                                                          prix: boutique.prix,
                                                          description: boutique
                                                              .description,
                                                          categorie:
                                                              boutique.categorie,
                                                          image: boutique.image,
                                                        )));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "$api_link/api_fresh/uploads/${boutique.image}",
                                                  height: 120,
                                                  width: 180,
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.5),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 8,
                                                  bottom: 8,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${boutique.nom}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Prix au kg",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${boutique.prix} F CFA",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                commande_fict(
                                                  boutique.id,
                                                  boutique.nom,
                                                  boutique.image,
                                                  1,
                                                  boutique.prix,
                                                  boutique.description,
                                                );
                                              },
                                              child: Container(
                                                decoration:
                                                    const BoxDecoration(
                                                  color: Color(0xFF006650),
                                                  shape: BoxShape.circle,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text("Chargement..."));
                            }
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center();
            }
          },
        ),

          // ==== LISTE DES CATÉGORIES ====
        FutureBuilder(
          future: homecat(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // ✅ évite double scroll
                itemBuilder: (BuildContext context, index) {
                  Categorie cate = snapshot.data[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cate.nomCategorie,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Categoriedetails(
                                    nom: cate.nomCategorie,
                                    cat: "${cate.id}",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Voir plus",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF006650)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // ==== PRODUITS PAR CATÉGORIE ====
                      SizedBox(
                        height: 200,
                        child: FutureBuilder<dynamic>(
                          future: boutique(cate.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  Boutique boutique = snapshot.data[index];
                                  return Container(
                                    width: 180,
                                    margin: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image + overlay
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                          id: boutique.id,
                                                          nom: boutique.nom,
                                                          prix: boutique.prix,
                                                          description: boutique
                                                              .description,
                                                          categorie:
                                                              boutique.categorie,
                                                          image: boutique.image,
                                                        )));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  "$api_link/api_fresh/uploads/${boutique.image}",
                                                  height: 120,
                                                  width: 180,
                                                  fit: BoxFit.cover,
                                                ),
                                                Container(
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.5),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 8,
                                                  bottom: 8,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${boutique.nom}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Prix au kg",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${boutique.prix} F CFA",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                commande_fict(
                                                  boutique.id,
                                                  boutique.nom,
                                                  boutique.image,
                                                  1,
                                                  boutique.prix,
                                                  boutique.description,
                                                );
                                              },
                                              child: Container(
                                                decoration:
                                                    const BoxDecoration(
                                                  color: Color(0xFF006650),
                                                  shape: BoxShape.circle,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: Text("Chargement..."));
                            }
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text("Aucune donnée disponible"));
            }
          },
        ),
      ],
    ),
  ),
);

  }
}
