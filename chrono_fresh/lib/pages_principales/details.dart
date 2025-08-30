import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/controlleurs/recette_api.dart';
import 'package:provider/provider.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/recette_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String? id;
  String? nom;
  String? prix;
  String? description;
  String? categorie;
  String? image;

  /* String? idVendeur;
  String? statut;
  String? qtreduc;
  String? mtreduc;*/

  Details({
    super.key,
    this.id,
    this.nom,
    this.prix,
    this.description,
    this.categorie,
    this.image,

    /* this.idVendeur,
      this.statut,
      this.qtreduc,
      this.mtreduc*/
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
    print("okkkkkkk");
  }

  int quantity = 1;
  var cart = FlutterCart();
  bool isLoggedIn = false;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;

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
/*
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
  }*/

  void showRecipeDetails(BuildContext context, titre, description) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(titre,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Fermer'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  commande_fict(id, nom, image, int qt, prix, mode) async {
    cart.addToCart(
        cartModel: CartModel(
            productId: id,
            productName: nom,
            productImages: [image],
            quantity: qt,
            variants: [
              ProductVariant(price: double.parse(prix)),
            ],
            //discount: double.parse(prix),
            productDetails: mode));
    Provider.of<CartProvider>(context, listen: false).addItem();

    const snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 131, 230, 167),
      content: Text('D---Article ajouté au panier'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(cart.cartLength);
    print(cart.subtotal);
    print(cart.total);

    //Navigator.pushReplacementNamed(context, 'accueil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.backspace_outlined)),
            Center(
              child: Image.network(
                "${api_link}/api_fresh/uploads/${widget.image}",
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.nom}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  /*SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  ),*/
                  const Text(
                    "Prix au Kg",
                    style: TextStyle(fontSize: 17, color: Colors.black45),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.prix} F CFA",
                    style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      print(isLoggedIn);
                      // if (isLoggedIn) {
                      commande_fict(widget.id, widget.nom, widget.image,
                          quantity, widget.prix, widget.description);
                      /* } else {
                      _showMyDialog();
                    }*/
                    },
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF006650),
                        ),
                        width: 35,
                        //padding: const EdgeInsets.symmetric(vertical: 16),
                        /* margin: const EdgeInsets.only(
                            bottom: 225, left: 24, right: 24),*/
                        //width: double.infinity,
                        child: const Column(children: [
                          Text(
                            "+",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /*  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity = quantity - 1;
                      });
                    },
                    icon: const Icon(Icons.minimize)),
                Container(
                  width: 30,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${quantity}",
                        fillColor: Colors.white,
                        hoverColor: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity = quantity + 1;
                      });
                    },
                    icon: const Icon(Icons.add_outlined)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                ),
                Text(
                  "${double.parse(widget.prix!) * quantity} Fcfa",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 27),
                ),
              ],
            ),*/
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const Divider(),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      'Détail du produit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          "${widget.description}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ExpansionTile(
                    title: const Text(
                      'Recettes avec ce produit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
  padding: const EdgeInsets.all(12.0),
  child: FutureBuilder<dynamic>(
    future: viewrec('${widget.id}'),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(
          child: Text(
            'Aucune recette disponible pour ce produit',
            style: TextStyle(color: Colors.black),
          ),
        );
      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
        return const Center(
          child: Text(
            'Aucune recette disponible',
            style: TextStyle(color: Colors.black),
          ),
        );
      } else {
        List<Mrecettes> recettes = snapshot.data;

        // Remplacement du `Wrap` par un `GridView.builder`
        return GridView.builder(
          // Pour éviter les problèmes de débordement de scrolling
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Configuration de la grille
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colonnes comme dans la maquette
            crossAxisSpacing: 10.0, // Espacement horizontal entre les cartes
            mainAxisSpacing: 5.0, // Espacement vertical entre les cartes
            childAspectRatio: 0.8, // Ratio pour que les cartes aient la bonne taille
          ),
          itemCount: recettes.length,
          itemBuilder: (context, index) {
            final recette = recettes[index];
            return GestureDetector(
              onTap: () {
                showRecipeDetails(context, recette.nomPlat, recette.description);
              },
              // Utilisation d'un `Card` pour une meilleure élévation et des bords arrondis
              child: Card(
                elevation: 4.0, // Ombre légère pour un effet 3D
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias, // Permet à l'image d'avoir des bords arrondis
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Image de la recette
                    Expanded(
                      child: Image.network(
                        // Assurez-vous que l'objet `Mrecettes` a une propriété `imageUrl`
                        "recette.imageUrl",
                        fit: BoxFit.cover, // L'image remplit l'espace sans déformation
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image));
                        },
                      ),
                    ),
                    // Nom de la recette
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recette.nomPlat,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Couleur verte comme dans la maquette
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
)
                     
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),

            /*  const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print(isLoggedIn);
                  // if (isLoggedIn) {
                  commande_fict(widget.id, widget.nom, widget.image, quantity,
                      widget.prix, widget.description);
                  /* } else {
                    _showMyDialog();
                  }*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Ajouter au panier',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
