import 'package:chrono_fresh/pages_principales/mescommandes_api.dart';
import 'package:chrono_fresh/pages_principales/mescommandes_structure.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mescommandes extends StatefulWidget {
  const Mescommandes({super.key});

  @override
  State<Mescommandes> createState() => _MescommandesState();
}

class Order {
  final String number;
  final String name;
  final String date;
  final String total;
  final String status;
  final Color statusColor;

  Order({
    required this.number,
    required this.name,
    required this.date,
    required this.total,
    required this.status,
    required this.statusColor,
  });
}

class _MescommandesState extends State<Mescommandes> {
  late Future ordersFuture;
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
    // TODO: implement initState
    super.initState();
    autoLogIn();
    ordersFuture = order(id);
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
  order(id) async {
    return await viewsorders(id);
    
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Mes Commandes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /* const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "December 2024",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),*/
          SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: FutureBuilder<dynamic>(
                            future: order(id),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder:
                                      (BuildContext context, int index) {
                                    Mcommande mcommande = snapshot.data[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/viande.jpeg', // Remplace cette image par la tienne
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text("N° ${mcommande.id}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("Total : ${mcommande.total} F",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              SizedBox(height: 4),
                              Text("${mcommande.dateCommande}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        
                   mcommande.statut =="0"   ? const Chip(
                          label: Text("En attente",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.orange,
                        ):  const Chip(
                          label: Text("En preparation",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                );
                ;
              },
            ),
          );}else{return Center(
                                  child: Text('Chargement...',
                                      style: TextStyle(color: Colors.black)),
                                );}
                                }
                          ),
                        ),
          )
        ],
      ),
    );
  }
}
