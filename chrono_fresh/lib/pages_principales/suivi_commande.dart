import 'dart:convert';
import 'package:chrono_fresh/global_var.dart';
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
  Suivicommande( {required this.idL, required this.idC, required this.idU});

  @override
  State<Suivicommande> createState() => _SuivicommandeState();
}

class _SuivicommandeState extends State<Suivicommande> {

  void _goToScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QRScannerPage(expectedCode: widget.idU, idC: widget.idC,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Suivre la commande'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: widget.idL == null ? Center(child: OrderStep(
              icon: Icons.receipt_long,
              title: 'Commande prise',
              isCompleted: true,
            ),) : FutureBuilder(
            future: getCourseDetails(widget.idL),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return  Center(child: OrderStep(
              icon: Icons.receipt_long,
              title: 'Commande prise',
              isCompleted: true,
            ),);
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return  Center(child: OrderStep(
              icon: Icons.receipt_long,
              title: 'Commande prise',
              isCompleted: true,
            ),);
              } else {
                final List course = snapshot.data;
                return ListView.builder(
                  itemCount: course.length,
                  itemBuilder: (BuildContext context, int index) {
                    final mc = course[index] as Course;
                    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            OrderStep(
              icon: Icons.kitchen,
              title: 'La commande est en cours de préparation',
              isCompleted: true,
            ),
            mc.livCourse == "1" ?
            OrderStep(
              icon: Icons.delivery_dining,
              title: 'Livraison en cours',
              subtitle: 'Le livreur est en route',
              isCompleted: false,
              showCallIcon: false,
              onLivraison: true,
            )
            :SizedBox(height: 10),
            mc.finCourse == "1" ?
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Center(child: ElevatedButton(
              onPressed: () => _goToScanner(context),
              child: Text("Scanner QR Code"),
            ),),
            ):
            SizedBox(height: 10),
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

  OrderStep({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.showCallIcon = false,
    this.isFinalStep = false,
    this.onLivraison = false
  });

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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ),
        if (isCompleted)
          Icon(Icons.check_circle, color: Colors.green),
        if (showCallIcon)
          Icon(Icons.call, color: Colors.orange),
          if(onLivraison)
          Text("- 4.5 km", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),)
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
        onDetect: (capture) async{
          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;

          if (code != null) {
            bool result = code == expectedCode;
            Navigator.pop(context);
            if (result){
              
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
  
            }
            else {
              showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Résultat'),
                content: Text(result ? '✅ Code reconnu' : '❌ Code NON reconnu'),
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
