import 'package:chrono_fresh/controlleurs/meszones_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/zones_structure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteAddressesPage extends StatefulWidget {
  const FavoriteAddressesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteAddressesPage> createState() => _FavoriteAddressesPageState();
}

class _FavoriteAddressesPageState extends State<FavoriteAddressesPage> {
  List<Map<String, String>> favoriteAddresses = [];
  late Future adressesFuture;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  int? editingIndex;

  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
    adressesFuture = adresses(id);
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');
    final String? coderole = prefs.getString('role');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = coderole;
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
      });
    }
  }

  adresses(id) async {
    return await viewlocation(id);
  }

  Future<void> _saveAddresses(idcli, name) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Or other accuracy levels
      );
      print('Latitude: ${position.latitude}');
      print('Longitude: ${position.longitude}');

      var url = Uri.parse("${api_link}/api_fresh/addmeszones.php");
      var data = {
        "idc": idcli,
        "nom": name,
        "long": '${position.longitude}',
        "lat": '${position.latitude}'
      };
      var res = await http.post(url, body: data);

      if (jsonDecode(res.body) == "true") {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'favorite_addresses', json.encode(favoriteAddresses));
        Fluttertoast.showToast(
            msg: "Merci, votre nouvelle adresse est pris en compte",
            toastLength: Toast.LENGTH_LONG);
      } else if (jsonDecode(res.body) == "asaved") {
        Fluttertoast.showToast(
            msg: "Vous avez deja donner cette adresse",
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print('Error getting current position: $e');
      // Handle errors (e.g., location permission denied)
    }
  }

  Future<void> _deleteAddress(cle) async {
    var url = Uri.parse("${api_link}/api_fresh/deletezone.php");
    var data = {
      "id": cle,
    };
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Adresse supprimer", toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "Erreur", toastLength: Toast.LENGTH_LONG);
    }
  }

  void _showAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Adresse'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _saveAddresses(id, nameController.text);
                    Navigator.pop(context);
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mes adresses favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 1.2,
          child: FutureBuilder<dynamic>(
              future: adresses(id),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Zones mzones = snapshot.data[index];
                      print(snapshot.data.length);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 30,
                                weight: 30,
                              ),
                              Text("${mzones.name}",
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.black)),
                              const SizedBox(width: 4),
                              IconButton(
                                  onPressed: () {
                                    _deleteAddress(mzones.id);
                                  },
                                  icon: Icon(
                                    Icons.restore_from_trash,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Chargement...',
                        style: TextStyle(color: Colors.black)),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[200],
        onPressed: () {
          _showAddModal();
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
