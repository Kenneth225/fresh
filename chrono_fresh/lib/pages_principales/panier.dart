import 'package:chrono_fresh/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  var cart = FlutterCart();
  List imgArray = [];
  List idArray = [];
  List priceArray = [];
  List qtArray = [];
  List nomArray = [];
  List unitprArray = [];
  var Montant = 0;
  var taille = FlutterCart().cartItemsList.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: taille > 1
              ? Column(children: [
                  ListView.builder(
                      itemCount: cart.cartLength,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item = cart.cartItemsList[index];
                        return Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.network(
                                    "${api_link}/api_fresh/uploads/${item.productImages?[0]}",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text('${item.productName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('${item.quantity}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(
                                  width: 18,
                                ),
                                IconButton(
                                    onPressed: () {
                                      //cart.removeItem(index[0]);
                                      cart.clearCart();
                                      /* Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Tissu retiré du panier",
                                    toastLength: Toast.LENGTH_SHORT);*/
                                    },
                                    icon: Icon(Icons.delete))
                              ]),
                        );
                      }),
                  Text("Total : ${cart.total} FCFA",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(15, 29, 55, 1),
                          Color.fromRGBO(15, 29, 55, 1),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          /* commander('${idArray}', '1', '${cart.getTotalAmount()}',
                        cart.getTotalAmount());*/
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Acheter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ])
              : Column(
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
