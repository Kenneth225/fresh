import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/boutique_api.dart';
import 'package:chrono_fresh/pages_principales/boutique_structure.dart';
import 'package:chrono_fresh/pages_principales/categorie_api.dart';
import 'package:chrono_fresh/pages_principales/categorie_structure.dart';
import 'package:chrono_fresh/pages_principales/categories_details.dart';
import 'package:chrono_fresh/pages_principales/details.dart';
import 'package:chrono_fresh/pages_principales/searchbar_api.dart';
import 'package:chrono_fresh/pages_principales/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cart/cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    autoLogIn();
    fetchAndStoreProducts();
    boutiqueFuture = boutique("1");
    categorieFuture = homecat();
  }

  var cart = FlutterCart();

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

    
    Fluttertoast.showToast(
        msg: "Article ajouté au panier",
        toastLength: Toast.LENGTH_SHORT);
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
       //backgroundColor: getRandomColor(),
       backgroundColor: Colors.white,
      body: /*Stack(fit: StackFit.expand, children: [
        Image.asset(
          "assets/roast_chicken.jpg",
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),*/
        SingleChildScrollView(
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
              ),

              //carousel dynamique

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
                        //color: getRandomColor(),
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
                          SizedBox(width: 10),
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
                                    color: Colors.green,
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

              //fin carousel

              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 1.6,
                  child: FutureBuilder(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                          nom:
                                                              "${cate.nomCategorie}",
                                                          cat: "${cate.id}",
                                                        )));
                                          },
                                          child: const Text(
                                            "...",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green),
                                          )),
                                      /*    DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style:
                                              const TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              dropdownValue = value!;
                                            });
                                          },
                                          items: const ["Voir tout", "Autre"]
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: FutureBuilder<dynamic>(
                                            future: boutique(cate.id),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                return GridView.builder(
                                                  itemCount:
                                                      snapshot.data.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    Boutique boutique =
                                                        snapshot.data[index];
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                      Navigator.of(context).push(MaterialPageRoute(
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
                                                                    child:
                                                                        ClipRRect(
                                                                      child: Image
                                                                          .network(
                                                                        "${api_link}/api_fresh/uploads/${boutique.image}",
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            80,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "1kg,Prix"),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            "${boutique.prix} fcfa"),
                                                                        const SizedBox(
                                                                          width:
                                                                              18,
                                                                        ),
                                                                        ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            minimumSize:
                                                                                MaterialStateProperty.all(const Size(10, 25)),
                                                                            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                                                                                70,
                                                                                225,
                                                                                106,
                                                                                1)),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            commande_fict(
                                                                                boutique.id,
                                                                                boutique.nom,
                                                                                boutique.image,
                                                                                1,
                                                                                boutique.prix,
                                                                                boutique.description);
                                                                          },
                                                                          child: const Icon(
                                                                              Icons.add_outlined,
                                                                              size: 18,
                                                                              color: Colors.white),
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
                ),
              ),
              const SizedBox(
                height: 203,
              )
            ],
          ),
        )
     // ]
      );
    //);
  }
}
