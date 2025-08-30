import 'dart:convert';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/controlleurs/meszones_api.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:chrono_fresh/pages_principales/mescommandes.dart';
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

  void callback(response, context) {
    switch (response['status']) {
      case PAYMENT_CANCELLED:
        Navigator.pop(context);
        debugPrint(PAYMENT_CANCELLED);
        _showMyinfo(response['status']);
        break;

      case PAYMENT_INIT:
        debugPrint(PAYMENT_INIT);
        break;

      case PENDING_PAYMENT:
        debugPrint(PENDING_PAYMENT);
        break;

      case PAYMENT_SUCCESS:
        commander(idArray, cart.cartLength, '${cart.total}');
        Navigator.pop(context);

        break;

      default:
        String? UNKNOWN_EVENT;
        debugPrint(UNKNOWN_EVENT);
        break;
    }
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
            // afficher les autres adresses enregistrer
           /* Expanded(
              child: SizedBox(
                height: 100,
                child: FutureBuilder<dynamic>(
                    future: adresses(id),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            max = snapshot.data.length;
                            Zones mzones = snapshot.data[index];
                            print(snapshot.data.length);
                            return TextButton(
                              child: Text("${mzones.name}"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                
                           
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('Aucune adresse enregistré',
                              style: TextStyle(color: Colors.black)),
                        );
                      }
                    }),
              ),
            ),*/
          ],
        );
      },
    );
  }

  Future<void> _showOrderdone() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Commande acceptée'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                  'assets/ok.jpg', // Remplace cette image par la tienne
                  width: 50,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Votre commande a été accepté",
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Vos articles ont été placé et sont en cours de traitement",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Suivre la commande"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Mescommandes(
                          id: "${id}",
                        )));
              },
            ),
            TextButton(
              child: const Text("Retour à l'acceuil"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'accueil');
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
                  const Text(
                    "Paiement",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
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
              const Text(
                "En passant une commande, vous acceptez nos Conditions générales",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (isLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KKiaPay(
                              amount: cart.total.toInt(), //
                              countries: ["BJ", "CI", "SN", "TG"], //
                              phone: "22997000000", //
                              name: "John Doe", //
                              email: "test@mail.com", //
                              reason: 'Paiement article reason', //
                              data: 'Fake data', //
                              sandbox: true, //
                              apikey: "b59e46603af611f09dfd63ae9443e3ce", //
                              callback: callback, //
                              theme: defaultTheme, // Ex : "#222F5A",
                              partnerId: 'AxXxXXxId', //
                              paymentMethods: ["momo", "card"] //
                              )),
                    );
                    // commander(idArray, cart.cartLength, '${cart.total}');
                  } else {
                    _showMyDialog();
                  }
                },
                child: const Text("Passer la commande",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  commander(idp, qtp, prixT) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Or other accuracy levels
      );
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      var url = Uri.parse("${api_link}/api_fresh/addcommandes.php");
      var data = {
        "IDcli": "${id}",
        "taille": qtp.toString(),
        "namep": nomArray.toString(),
        "imgp": imgArray.toString(),
        "montantT": prixT.toString(),
        "IDproduit": idArray.toString(),
        "pu": unitprArray.toString(),
        "quant": qtArray.toString(),
        "nom": "${prenom}",
        "lat": "${position.latitude}",
        "long": "${position.longitude}"
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
        Provider.of<CartProvider>(context, listen: false).clearCart();
        _showOrderdone();
      } else {
        Fluttertoast.showToast(msg: "Erreur", toastLength: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print('Error getting current position: $e');
      // Handle errors (e.g., location permission denied)
      setState(() {
        load = false;
      });
    }
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mon panier",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
                            const SizedBox(width: 12),

                            // Nom + détail + bouton +/-
                            Expanded(
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
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle,
                                            color: Colors.green),
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            setState(() {
                                              cart.updateQuantity(
                                                  item.productId,
                                                  item.variants,
                                                  item.quantity - 1);
                                            });
                                          }
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          "${item.quantity}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle,
                                            color: Colors.green),
                                        onPressed: () {
                                          if (item.quantity < 10) {
                                            setState(() {
                                              cart.updateQuantity(
                                                  item.productId,
                                                  item.variants,
                                                  item.quantity + 1);
                                            });
                                          }
                                        },
                                      ),
                                    ],
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
                                      color: Colors.green),
                                  onPressed: () {
                                    _removeItem(item.productId, item.variants);
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .removeItem();
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
                    cart.clearCart();
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.green),
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
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          _showPaymentModal(context);
                        },
                        child: const Text(
                          "Valider mon panier",
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
