import 'dart:convert';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/controlleurs/meszones_api.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:chrono_fresh/pages_principales/mescommandes.dart';
import 'package:chrono_fresh/pages_principales/recap_paiement.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:chrono_fresh/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:provider/provider.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  int max = 0;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  bool isLoggedIn = false;
  bool load = false;
  var cart = FlutterCart();
  List imgArray = [];
  List idArray = [];
  List priceArray = [];
  List qtArray = [];
  List nomArray = [];
  List unitprArray = [];
  var Montant = 0;
  late int qt;
  var taille = FlutterCart().cartItemsList.length;

  initState() {
    super.initState();

    autoLogIn();
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

  void _removeItem(id, variants) {
    setState(() {
      cart.removeItem(id, variants);
    });
  }

  adresses(id) async {
    return await viewlocation(id);
  }

  Future<void> _showMyinfo(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
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

  Future<void> _showMymap() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selectioner le lieu de livraison'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                  'assets/mapss.png', // Remplace cette image par la tienne
                  width: 50,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Ma position actuel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  


  

  Widget _buildOptionRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Text(value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF006650),
        elevation: 0,
        title: const Text(
          "Mon panier",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: taille >= 1
          ? Column(
              children: [
                // Nombre d'articles
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${cart.cartLength} articles",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),

                // Liste des produits
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartLength,
                    itemBuilder: (BuildContext context, int index) {
                      var item = cart.cartItemsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image produit
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${api_link}/api_fresh/uploads/${item.productImages?[0]}",
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 10),

                            // Nom + détail + bouton +/-
                             Flexible(
                               child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${item.variants.first.price} F CFA ",
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 8),
                               
                                    // Boutons +/-
                                    Container(
                                      //width: 100,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF006650),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      //color: Color(0xFF006650),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            iconSize: 12,
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white),
                                            onPressed: () {
                                              if (item.quantity > 1) {
                                                setState(() {
                                                  cart.updateQuantity(
                                                      item.productId,
                                                      item.variants,
                                                      item.quantity - 1);
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .removeItem();
                                                });
                                              }
                                            },
                                          ),
                                          Text(
                                            "${item.quantity}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            iconSize: 12,
                                            icon: const Icon(Icons.add,
                                                color: Colors.white),
                                            onPressed: () {
                                              if (item.quantity < 10) {
                                                setState(() {
                                                  cart.updateQuantity(
                                                      item.productId,
                                                      item.variants,
                                                      item.quantity + 1);
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .addItem();
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                             ),
                            

                            // Prix + bouton supprimer
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete_outline,
                                      color: Color.fromARGB(255, 195, 80, 80)),
                                  onPressed: () {
                                    _removeItem(item.productId, item.variants);

                                    for (var i = 0; i < item.quantity; i++) {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .removeItem();
                                    }
                                  },
                                ),
                                Text(
                                  "${item.variants.first.price * item.quantity} F CFA",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Vider panier
                TextButton.icon(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .clearCart();
                    cart.clearCart();
                    Navigator.pushReplacementNamed(context, 'accueil');
                  },
                  icon: const Icon(Icons.delete_outline,
                      color: Color.fromARGB(255, 195, 80, 80)),
                  label: const Text("Vider mon panier",
                      style: TextStyle(color: Colors.black)),
                ),

                // Footer avec total + bouton valider
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${cart.total} F CFA",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF006650),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          //Ajout des produits au tableaux
                          cart.cartItemsList.forEach((f) {
                            nomArray.add(f.productName);
                            qtArray.add(f.quantity);
                            imgArray.add(f.productImages?[0]);
                            unitprArray.add(f.variants.isNotEmpty
                                ? f.variants[0].price
                                : null); // Ajout du prix
                            idArray.add(f.productId);
                          });
                          print('$nomArray');
                          print('$qtArray');
                          print('$unitprArray');
                          print('$imgArray');
                          print(cart.cartLength);
                          
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    imgArray: [imgArray],
                                    idArray: [idArray],
                                    priceArray: [priceArray],
                                    nomArray: [nomArray],
                                    qtArray: [qtArray],
                                    unitprArray: [unitprArray],
                                  )));
                          
                        },
                        child: const Text(
                          "Valider mon panier",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/bempty.jpg", height: 150),
                  const SizedBox(height: 12),
                  const Text("Vous n'avez aucun article dans votre panier"),
                ],
              ),
            ),
    );
  }
}
