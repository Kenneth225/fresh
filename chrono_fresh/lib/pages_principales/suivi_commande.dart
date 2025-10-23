import 'dart:convert';
import 'package:chrono_fresh/controlleurs/detailscommandes_api.dart';
import 'package:chrono_fresh/controlleurs/mescommandes_api.dart';
import 'package:chrono_fresh/global_var.dart';
import 'package:chrono_fresh/models/detailscommande_structure.dart';
import 'package:chrono_fresh/models/mescommandes_structure.dart';
import 'package:http/http.dart' as http;
import 'package:chrono_fresh/controlleurs/course_api.dart';
import 'package:chrono_fresh/models/course_structure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Suivicommande extends StatefulWidget {
  final String idC;
  final String idU;
  final String idL;
  Suivicommande({required this.idL, required this.idC, required this.idU});

  @override
  State<Suivicommande> createState() => _SuivicommandeState();
}

class _SuivicommandeState extends State<Suivicommande> {
  late Future ordersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersFuture = order(widget.idC);
  }

  order(id) async {
    return await viewsdetorders(id);
  }

  morder(id) async {
    return await viewsorders(id);
  }
  void _goToScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QRScannerPage(
          expectedCode: widget.idU,
          idC: widget.idC,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF006650),
        title: Text('Suivre la commande', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: widget.idL == null
                ? Center(
                    child: OrderStep(
                      icon: Icons.receipt_long,
                      title: 'Command9 prise',
                      isCompleted: true,
                    ),
                  )
                : FutureBuilder(
                    future: morder(widget.idL),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: OrderStep(
                            icon: Icons.receipt_long,
                            title: 'Commande prise',
                            isCompleted: true,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                        return Center(
                          child: OrderStep(
                            icon: Icons.receipt_long,
                            title: 'Commande prise',
                            isCompleted: true,
                          ),
                        );
                      } else {
                        
                        final List course = snapshot.data;
                        return ListView.builder(
                          itemCount: course.length,
                          itemBuilder: (BuildContext context, int index) {
                            Mcommande mcommande = snapshot.data[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderStep(
                                  icon: Icons.kitchen,
                                  title:
                                      'La commande est en cours de préparation',
                                  isCompleted: true,
                                ),
                                mcommande.statut == "1"
                                    ? OrderStep(
                                        icon: Icons.delivery_dining,
                                        title: 'Livraison en cours',
                                        subtitle: 'Le livreur est en route',
                                        isCompleted: false,
                                        showCallIcon: false,
                                        onLivraison: true,
                                      )
                                    : SizedBox(height: 10),
                              /*  
                              A utiliser quand l'app livreur sera fonctionnel pour scaner qr code
                              mc.finCourse == "1"
                                    ? Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                _goToScanner(context),
                                            child: Text("Scanner QR Code"),
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: 10),*/
                                /*  OrderStep(
                  icon: Icons.check_circle,
                  title: 'Commande reçue',
                  isCompleted: true,
                  isFinalStep: true,
                ),*/
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
          Divider(),
          const Text("ARTICLES COMMANDES", style:  TextStyle (fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),
                Text("Produits",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 12),
                Text("Quantité",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 12),
                Text("Prix unitaire ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 1.2,
                child: FutureBuilder<dynamic>(
                    future: order(widget.idU),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Dcom mcommande = snapshot.data[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(),
                                Column(
                                  children: [
                                    Image.network(
                                      "$link_photo/${mcommande.image}",
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(" ${mcommande.nom}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black)),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(" ${mcommande.quantite}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                const SizedBox(width: 10),
                                Text("${mcommande.prixUnitaire} F CFA",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
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
          )
        ],
      ),
    );
  }
}

class OrderStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool showCallIcon;
  final bool isFinalStep;
  final bool onLivraison;

  OrderStep(
      {required this.icon,
      required this.title,
      this.subtitle,
      this.isCompleted = false,
      this.showCallIcon = false,
      this.isFinalStep = false,
      this.onLivraison = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: isCompleted ? Colors.green : Colors.orange, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ),
        if (isCompleted) Icon(Icons.check_circle, color: Colors.green),
        if (showCallIcon) Icon(Icons.call, color: Colors.orange),
        if (onLivraison)
          Text(
            "- 4.5 km",
            style: TextStyle(
                color: Colors.amberAccent, fontWeight: FontWeight.bold),
          )
      ],
    );
  }
}

class QRScannerPage extends StatelessWidget {
  final String expectedCode;
  final String idC;

  QRScannerPage({required this.expectedCode, required this.idC});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner")),
      body: MobileScanner(
        onDetect: (capture) async {
          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;

          if (code != null) {
            bool result = code == expectedCode;
            Navigator.pop(context);
            if (result) {
              var url = Uri.parse("${api_link}/api_fresh/validatecourse.php");
              var data = {"idc": idC};
              var res = await http.post(url, body: data);

              if (jsonDecode(res.body) == "true") {
                Fluttertoast.showToast(
                    msg: "Course Terminé", toastLength: Toast.LENGTH_LONG);
              } else {
                Fluttertoast.showToast(
                    msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
              }
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Résultat'),
                  content:
                      Text(result ? '✅ Code reconnu' : '❌ Code NON reconnu'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Fermer'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
