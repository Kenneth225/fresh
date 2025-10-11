import 'dart:convert';
import 'package:chrono_fresh/pages_principales/confirmation.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/controlleurs/meszones_api.dart';
import 'package:chrono_fresh/controlleurs/pliv_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/pliv_structure.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  List? imgArray = [];
  List? idArray = [];
  List? priceArray = [];
  List? qtArray = [];
  List? nomArray = [];
  List? unitprArray = [];

  CheckoutPage(
      {super.key,
      this.imgArray,
      required this.idArray,
      required this.priceArray,
      required this.nomArray,
      required this.qtArray,
      required this.unitprArray});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int max = 0;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  List imgArray = [];
  List idArray = [];
  List priceArray = [];
  List qtArray = [];
  List nomArray = [];
  List unitprArray = [];
  double prixliv = 0;
  double prixTotal = 0;
  bool isLoggedIn = false;
  bool load = false;
  var cart = FlutterCart();
  late Future PriceFuture;
  var Montant = 0;
  late int qt;
  var taille = FlutterCart().cartItemsList.length;
  var long;
  var lat;
  var adr;

  // --- Pour la gestion des adresses ---
  String? selectedAddress; // contiendra l'id d'une zone OU "autre"
  bool useCustomAddress = false;
  final TextEditingController customAddressController = TextEditingController();

  DateTime? selectedDate;
  List<Zones> _lastFetchedAddresses = []; // pour retrouver la zone choisie

  @override
  void initState() {
    super.initState();
    autoLogIn();
    PriceFuture = fraisliv();
    PriceFuture.then((data) {
      if (data.isNotEmpty) {
        setState(() {
          prixliv = double.parse("${data[0].prix}");
          prixTotal = cart.total + prixliv;
        });
      }
    });
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
        commander(idArray, cart.cartLength, '${cart.total}', long, lat, adr);
        Navigator.pop(context);

        break;

      default:
        String? UNKNOWN_EVENT;
        debugPrint(UNKNOWN_EVENT);
        break;
    }
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

  // appel à ton API
  Future<List<Zones>> adresses(id) async {
    return await viewlocation(id);
  }

  fraisliv() async {
    return await viewprice();
  }

  commander(idp, qtp, prixT, long, lat, adr) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Or other accuracy levels
      );
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      String cleanBrackets(String value) {
        if (value.startsWith('[') && value.endsWith(']')) {
          return value.substring(1, value.length - 1);
        }
        return value;
      }

      var url = Uri.parse("${api_link}/api_fresh/addcommandes.php");
      var data = {
        "IDcli": "${id}",
        "taille": qtp.toString(),
        "namep": cleanBrackets(widget.nomArray.toString()),
        "imgp": cleanBrackets(widget.imgArray.toString()),
        "montantT": prixT.toString(),
        "IDproduit": cleanBrackets(widget.idArray.toString()),
        "pu": cleanBrackets(widget.unitprArray.toString()),
        "quant": cleanBrackets(widget.qtArray.toString()),
        "nom": "${prenom}",
        "adr": "${adr}",
        "lat": "${lat}",
        "long": "${long}",
        "dliv": "${selectedDate}"
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmationPage(id: "${id}")));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Information et paiement",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF006650),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Sélecteur d'adresse ----
            FutureBuilder<List<Zones>>(
              future: adresses(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  // return Text("Erreur: ${snapshot.error}");
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Adresse de livraison",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          DropdownButton<String>(
                            value: selectedAddress,
                            hint: const Text("Sélectionner une adresse"),
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: "gps",
                                child: Text("Adresse actuel"),
                              ),
                              DropdownMenuItem(
                                value: "autre",
                                child: Text("Autre adresse"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value;
                                useCustomAddress = value == "autre";
                              });
                            },
                          ),
                          if (useCustomAddress) ...[
                            const SizedBox(height: 8),
                            TextField(
                              controller: customAddressController,
                              decoration: const InputDecoration(
                                labelText: "Saisir une adresse",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text(
                    'Aucune adresse enregistrée',
                    style: TextStyle(color: Colors.black),
                  );
                }

                final addresses = snapshot.data!;
                _lastFetchedAddresses =
                    addresses; // sauvegarde pour valider après

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Adresse de livraison",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        DropdownButton<String>(
                          value: selectedAddress,
                          hint: const Text("Sélectionner une adresse"),
                          isExpanded: true,
                          items: [
                            ...addresses.map((zone) => DropdownMenuItem(
                                  value: zone.id,
                                  child: Text(zone.name ?? ""),
                                )),
                            const DropdownMenuItem(
                              value: "gps",
                              child: Text("Adresse actuel"),
                            ),
                            const DropdownMenuItem(
                              value: "autre",
                              child: Text("Autre adresse"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                              useCustomAddress = value == "autre";
                            });
                          },
                        ),
                        if (useCustomAddress) ...[
                          const SizedBox(height: 8),
                          TextField(
                            controller: customAddressController,
                            decoration: const InputDecoration(
                              labelText: "Saisir une adresse",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // ---- Sélecteur de date ----
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.green),
                title: Text(selectedDate == null
                    ? "Sélectionner une date de livraison"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () async {
                  final now = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 1),
                    locale: const Locale("fr", "FR"),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 16),

            // ---- Paiement recap ----
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Paiement",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        cart.cartLength <= 1
                            ? Text("${cart.cartLength} article")
                            : Text("${cart.cartLength} articles"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Montant"),
                        Text("${cart.total} F FCA"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Frais de livraison"),
                        FutureBuilder(
                          future: PriceFuture,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData && snapshot.data.isNotEmpty) {
                              // Si viewprice() renvoie une liste
                              Pliv p = snapshot.data[0];

                              return Text(
                                "${p.prix} F CFA",
                                style: const TextStyle(color: Colors.black),
                              );
                            } else {
                              return const Text("0 F CFA");
                            }
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("$prixTotal  F FCA",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // ---- Bouton paiement ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (selectedDate == null) {
                    print("pas de date");
                    const snackBar = SnackBar(
                      backgroundColor: Color.fromRGBO(217, 164, 65, 1),
                      content: Text('Selectionnez une date de livraison'),
                    );
                    Fluttertoast.showToast(
          msg: "Selectionnez une date de livraison",
          toastLength: Toast.LENGTH_LONG);
                  } else {
                    if (useCustomAddress) {
                      print("Adresse saisie : ${customAddressController.text}");
                      setState(() {
                        long = 0;
                        lat = 0;
                        adr = customAddressController.text;
                      });

                      commander(widget.idArray, cart.cartLength, '${prixTotal}',
                          long, lat, adr);
                    } else if (selectedAddress != null) {
                      final zoneChoisie = _lastFetchedAddresses.firstWhere(
                        (z) => z.id == selectedAddress,
                        orElse: () =>
                            Zones(id: selectedAddress, name: "Inconnue"),
                      );
                      print(
                          "Adresse choisie : ${zoneChoisie.name} (id: ${zoneChoisie.id})");
                      if ("${zoneChoisie.name}" != "Inconnue") {
                        setState(() {
                          long = "${zoneChoisie.longitude}";
                          lat = "${zoneChoisie.latitude}";
                          adr = "Benin";
                        });

                        commander(widget.idArray, cart.cartLength,
                            '${prixTotal}', long, lat, adr);
                      } else {
                        try {
                          Position position =
                              await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy
                                .high, // Or other accuracy levels
                          );
                          print('Latitude: ${position.latitude}');
                          print('Longitude: ${position.longitude}');
                          setState(() {
                            long = "${position.longitude}";
                            lat = "${position.latitude}";
                            adr = "Benin";
                          });

                          commander(widget.idArray, cart.cartLength,
                              '${prixTotal}', long, lat, adr);
                        } catch (e) {
                          print('Error getting current position: $e');
                          // Handle errors (e.g., location permission denied)
                          setState(() {
                            load = false;
                          });
                        }
                      }
                    }
                  }

                  print("Date choisie : $selectedDate");

                  if (isLoggedIn) {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KKiaPay(
                              amount: cart.total.toInt(), //
                              countries: ["BJ", "CI", "SN", "TG"], //
                              phone: "22961000000", //
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
                    );*/
                    //commander(widget.idArray, cart.cartLength, '${prixTotal}');
                  } else {
                    _showMyDialog();
                  }
                },
                child: const Text(
                  "Passer au paiement via KKiaPay",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Vous allez être redirigé vers la plateforme de paiement.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
