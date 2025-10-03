import 'package:chrono_fresh/controlleurs/meszones_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  List? imgArray = [];
  List? idArray = [];
  List? priceArray = [];
  List? qtArray = [];
  List? nomArray = [];
  List? unitprArray = [];

  CheckoutPage({super.key,
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
  bool isLoggedIn = false;
  bool load = false;
  var cart = FlutterCart();

  var Montant = 0;
  late int qt;
  var taille = FlutterCart().cartItemsList.length;

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

  // appel à ton API
  Future<List<Zones>> adresses(id) async {
    return await viewlocation(id);
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
                          items: [
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
                    ? "Sélectionner une date"
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
                        cart.cartLength <= 1 ?
                        Text("${cart.cartLength} article"): Text("${cart.cartLength} articles"),
                       // Text("${widget.nomArray}"),
                       /* ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "${api_link}/api_fresh/uploads/${widget.imgArray?[0]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://via.placeholder.com/60",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),*/
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("Montant"),
                        Text("${cart.total} F FCA"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Frais de livraison"),
                        Text("45 F FCA"),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("947 F FCA",
                            style: TextStyle(
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
                onPressed: () {
                  if (useCustomAddress) {
                    print("Adresse saisie : ${customAddressController.text}");
                  } else if (selectedAddress != null) {
                    final zoneChoisie = _lastFetchedAddresses.firstWhere(
                      (z) => z.id == selectedAddress,
                      orElse: () =>
                          Zones(id: selectedAddress, name: "Inconnue"),
                    );
                    print(
                        "Adresse choisie : ${zoneChoisie.name} (id: ${zoneChoisie.id})");
                  }
                  print("Date choisie : $selectedDate");
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
