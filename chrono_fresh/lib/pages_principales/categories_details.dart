import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/pages_principales/boutique_all_api.dart';
import 'package:chrono_fresh/pages_principales/boutique_structure.dart';
import 'package:chrono_fresh/pages_principales/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';

// ignore: must_be_immutable
class Categoriedetails extends StatefulWidget {
  String? nom;
  String? cat;

  Categoriedetails({super.key, this.nom, this.cat});

  @override
  State<Categoriedetails> createState() => _CategoriedetailsState();
}

class _CategoriedetailsState extends State<Categoriedetails> {
  late Future boutiqueFuture;
  String categorie = "";
  var cart = FlutterCart();
  void initState() {
    super.initState();
    print("jai ete demarrer");
    boutiqueFuture = boutique(widget.cat);
  }

  boutique(categorie) async {
    return await viewboutique(categorie);
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

    const snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 131, 230, 167),
      content: Text('Article ajouté au panier'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(cart.cartLength);
    print(cart.subtotal);
    print(cart.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.nom}"),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: FutureBuilder<dynamic>(
            future: boutique("${widget.cat}"),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
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
                            width: 165,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Details(
                                                    id: boutique.id,
                                                    nom: boutique.nom,
                                                    prix: boutique.prix,
                                                    description:
                                                        boutique.description,
                                                    categorie:
                                                        boutique.categorie,
                                                    image: boutique.image,
                                                  )));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
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
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => Details(
                                                      id: boutique.id,
                                                      nom: boutique.nom,
                                                      prix: boutique.prix,
                                                      description:
                                                          boutique.description,
                                                      categorie:
                                                          boutique.categorie,
                                                      image: boutique.image,
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
                                  Text("1kg,Prix"),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text("${boutique.prix} fcfa"),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(10, 25)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      70, 225, 106, 1)),
                                        ),
                                        onPressed: () {
                                          commande_fict(
                                              boutique.id,
                                              boutique.nom,
                                              boutique.image,
                                              1,
                                              boutique.prix,
                                              boutique.description);
                                        },
                                        child: const Icon(Icons.add_outlined,
                                            size: 18, color: Colors.white),
                                      ),
                                      /* Container(
                                        height: 25,
                                              width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient:
                                                const LinearGradient(colors: [
                                              Color.fromRGBO(
                                                  14, 232, 62, 0.667),
                                              Color.fromRGBO(70, 225, 106, 1),
                                            ])),
                                        child: Center(
                                          child: TextButton(
                                            onPressed: () {},
                                            child: const Row(
                                              verticalDirection:
                                                  VerticalDirection.up,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "+",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),*/
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  child: Text('Aucun produit correspondant',
                      style: TextStyle(color: Colors.black)),
                );
              }
            }),
      ),
    );
  }
}
