import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:chrono_fresh/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  bool isLoggedIn = false;
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

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Paiement",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    _showMymap();
                  },
                  child: _buildOptionRow("Livraison", "Choisir le lieu")),
              _buildOptionRow("Paiement", "🇧🇯"),
              _buildOptionRow("Coût total", "${cart.total} Fcfa"),
              const SizedBox(height: 10),
              Text(
                "En passant une commande, vous acceptez nos Conditions générales",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (isLoggedIn) {
                    commander(idArray, cart.cartLength, '${cart.total}');
                    Navigator.pop(context);
                  } else {
                    _showMyDialog();
                  }
                },
                child: Text("Passer la commande",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  commander(idp, qtp, prixT) async {
    var url = Uri.parse("${api_link}/api_fresh/addcommandes.php");
    var data = {
      "IDcli": "${id}",
      "taille": qtp.toString(),
      "namep" : nomArray.toString(),
      "imgp": imgArray.toString(),
      "montantT": prixT.toString(),
      "IDproduit": idArray.toString(),
      "pu": unitprArray.toString(),
      "quant": qtArray.toString(),
      "nom": "${prenom}",
    };

    var res = await http.post(url, body: data);
    if (jsonDecode(res.body) == "true") {
      print("la reponse: ");
      print(jsonDecode(res.body));
      Fluttertoast.showToast(
          msg: "Commande Effectué", toastLength: Toast.LENGTH_SHORT);
      cart.clearCart();
      unitprArray.clear();
      idArray.clear();
      imgArray.clear();
      Navigator.pushReplacementNamed(context, 'accueil');
    } else {
      Fluttertoast.showToast(msg: "Erreur", toastLength: Toast.LENGTH_SHORT);
    }
  }

  Widget _buildOptionRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Text(value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panier"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: taille >= 1
            ? SingleChildScrollView(
                child: Column(children: [
                  ListView.builder(
                      itemCount: cart.cartLength,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item = cart.cartItemsList[index];
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Card(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(children: [
                                  Image.network(
                                    "${api_link}/api_fresh/uploads/${item.productImages?[0]}",
                                    height: 50,
                                    width: 60,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(width: 16),
                                ]),
                                Column(
                                  children: [
                                    Text('${item.productName}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const Text("1kg, Prix",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (item.quantity <= 1) {
                                                print("rien a faire");
                                              } else {
                                                setState(() {
                                                  cart.updateQuantity(
                                                      item.productId,
                                                      item.variants,
                                                      item.quantity - 1);
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.minimize)),
                                        Container(
                                          height: 60,
                                          width: 45,
                                          child: TextField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                //filled: true,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                hintText: "${item.quantity}",
                                                fillColor: Colors.white,
                                                hoverColor: Colors.white),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (item.quantity >= 10) {
                                                print("rien a faire");
                                              } else {
                                                setState(() {
                                                  cart.updateQuantity(
                                                      item.productId,
                                                      item.variants,
                                                      item.quantity + 1);
                                                });
                                              }
                                            },
                                            icon:
                                                const Icon(Icons.add_outlined)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.close, color: Colors.grey),
                                      onPressed: () => _removeItem(
                                          item.productId, item.variants),
                                    ),
                                    Text("${item.variants.first.price} FCFA",
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
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
                        _showPaymentModal(context);
                      },
                      child: Text("Aller à la caisse •  ${cart.total} Fcfa",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ]),
              )
            : Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 50,
                    ),
                    Text(
                        "Vous n'avez aucun article dans votre panier ${taille}")
                  ],
                ),
              ),
      ),
    );
  }
}
