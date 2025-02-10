import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}


class _PanierState extends State<Panier> {

var cart = FlutterCart();
var Montant = 0;

  @override
  

  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [Icon(Icons.shopping_basket_outlined, size: 50,),
          Text("Vous n'avez aucun article dans votre panier !}")
          ],
        ),
      ),),
    );
  }
}