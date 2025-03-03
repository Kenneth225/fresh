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
import 'package:flutter_cart/cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
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

  @override
  void initState() {
    super.initState();
    autoLogIn();
    
    boutiqueFuture = boutique("1");
    categorieFuture = homecat();
  }

  bool isLoggedIn = false;
  String mail = '';
  String role = "1";

  var cart = FlutterCart();

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('usermail');
    final String? role = prefs.getString('role');

    if (mail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail!;
       // role = role;
      });
      Navigator.pushReplacementNamed(context, 'accueil');
    }
  }

  boutique(categorie) async {
    return await viewboutique(categorie);
  }

  homecat() async {
    return await viewcat();
  }

  commande_fict(id,  nom,  image, qt, prix,mode) async {
            cart.addToCart(
                      cartModel: CartModel(
                          productId: id,
                          productName: nom,
                          productImages: [image],
                          quantity: 1,
                          variants: [ProductVariant(price: double.parse(prix)),],
                          //discount: double.parse(prix),
                          productDetails: mode));

    const snackBar = SnackBar(
      backgroundColor: Colors.orangeAccent,
      content: Text('Consulter votre panier en haut de page'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(cart.cartLength);
    print(cart.subtotal);
    print(cart.total);

    Navigator.pushReplacementNamed(context, 'accueil');
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
                                                                        () {
                                                                          if (isLoggedIn) {
                                                                            
                                                                             commande_fict(boutique.id,  boutique.nom,  boutique.image, boutique.stock, boutique.prix , boutique.description);

                                                                          } else {
                                                                            _showMyDialog();
                                                                          }
                                                                        },
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
