import 'dart:math';
import 'dart:ui';
import 'package:chrono_fresh/controlleurs/categoriesall_api.dart';
import 'package:chrono_fresh/controlleurs/notif_pub_api.dart';
import 'package:chrono_fresh/controlleurs/sboutique_api.dart';
import 'package:chrono_fresh/controlleurs/scategorie_api.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrono_fresh/controlleurs/boutique_api.dart';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
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

class boutique extends StatefulWidget {
  const boutique({super.key});

  @override
  State<boutique> createState() => _boutiqueState();
}

class _boutiqueState extends State<boutique> {
  late Future boutiqueFuture;
  late Future categorieFuture;
  late Future notificationFuture;
  String categorie = "";
  bool isLoggedIn = false;
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
    notificationFuture = notif();
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

  notif() async {
    return await viewnotif();
  }

  homecat() async {
    return await viewcatall();
  }

  scat() async {
    return await viewscat();
  }

  sboutique(categorie) async {
    return await viewspromo(categorie);
  }

  commande_fict(id, nom, image, int qt, prix, mode) async {
    if (isLoggedIn) {
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
    } else {
      _showMyDialog();
    }
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


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ==== CAROUSEL ====

                    FutureBuilder(
                      future:
                          notificationFuture, // doit renvoyer Future<List<Notifications>>
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("Aucune donnée trouvée"));
                        }

                        final notifications = snapshot.data!;

                        return CarouselSlider.builder(
                          itemCount: notifications.length,
                          options: CarouselOptions(
                            height: 120,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final notif = notifications[index];

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
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
                                      "$api_link/api_fresh/uploads/${notif.image}" ??
                                          "", // sécurité si null
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notif.titre ?? "",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          notif.sousTitre ?? "",
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
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Catégories",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder<dynamic>(
                        future: homecat(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                'Aucune categorie disponible',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data.isEmpty) {
                            return const Center(
                              child: Text(
                                'Aucune categorie disponible',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          } else {
                            List<Categorie> cate = snapshot.data;

                            // Remplacement du `Wrap` par un `GridView.builder`
                            return GridView.builder(
                              // Pour éviter les problèmes de débordement de scrolling
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // Configuration de la grille
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // 2 colonnes comme dans la maquette
                                crossAxisSpacing:
                                    10.0, // Espacement horizontal entre les cartes
                                mainAxisSpacing:
                                    5.0, // Espacement vertical entre les cartes
                                childAspectRatio:
                                    0.8, // Ratio pour que les cartes aient la bonne taille
                              ),
                              itemCount: cate.length,
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
                                  // Utilisation d'un `Card` pour une meilleure élévation et des bords arrondis
                                  child: Card(
                                    color: Colors.white,
                                    // elevation: 4.0, // Ombre légère pour un effet 3D
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    clipBehavior: Clip
                                        .antiAlias, // Permet à l'image d'avoir des bords arrondis
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        // Image de la recette
                                        Expanded(
                                          child: Image.network(
                                            // Assurez-vous que l'objet `Mrecettes` a une propriété `imageUrl`
                                            "$api_link/api_fresh/uploads/${cate.visuel}",
                                            fit: BoxFit
                                                .fitWidth, // L'image remplit l'espace sans déformation
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child:
                                                      Icon(Icons.broken_image));
                                            },
                                          ),
                                        ),
                                        // Nom de la recette
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cate.nomCategorie,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .black, // Couleur verte comme dans la maquette
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // ==== LISTE DES CATÉGORIES SPECIAL====
                    FutureBuilder(
                      future: scat(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // ✅ évite double scroll
                            itemBuilder: (BuildContext context, index) {
                              Categorie cate = snapshot.data[index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          cate.nomCategorie,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Categoriedetails(
                                                nom: cate.nomCategorie,
                                                cat: "${cate.id}",
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Voir plus",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF006650)),
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
                                              Boutique boutique =
                                                  snapshot.data[index];
                                              return Container(
                                                width: 180,
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Image + overlay
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Details(
                                                                          id: boutique
                                                                              .id,
                                                                          nom: boutique
                                                                              .nom,
                                                                          prix:
                                                                              boutique.prix,
                                                                          description:
                                                                              boutique.description,
                                                                          categorie:
                                                                              boutique.categorie,
                                                                          image:
                                                                              boutique.image,
                                                                        )));
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    Colors
                                                                        .transparent,
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment
                                                                      .topCenter,
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
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Prix au kg",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
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
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${boutique.prix} F CFA",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              boutique
                                                                  .description,
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF006650),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
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
                            physics:
                                const NeverScrollableScrollPhysics(), // ✅ évite double scroll
                            itemBuilder: (BuildContext context, index) {
                              Categorie cate = snapshot.data[index];
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          cate.nomCategorie,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Categoriedetails(
                                                nom: cate.nomCategorie,
                                                cat: "${cate.id}",
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Voir plus",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF006650)),
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
                                              Boutique boutique =
                                                  snapshot.data[index];
                                              return Container(
                                                width: 180,
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Image + overlay
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Details(
                                                                          id: boutique
                                                                              .id,
                                                                          nom: boutique
                                                                              .nom,
                                                                          prix:
                                                                              boutique.prix,
                                                                          description:
                                                                              boutique.description,
                                                                          categorie:
                                                                              boutique.categorie,
                                                                          image:
                                                                              boutique.image,
                                                                        )));
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    Colors
                                                                        .transparent,
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment
                                                                      .topCenter,
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
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    "Prix au kg",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
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
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${boutique.prix} F CFA",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              boutique
                                                                  .description,
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF006650),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
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
                          return const Center(
                              child: Text("Aucune donnée disponible"));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
