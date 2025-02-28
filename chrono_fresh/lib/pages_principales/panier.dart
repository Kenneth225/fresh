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

  void _incrementQuantity(qty) {
    setState(() {
      qty++;
    });
  }

  void _decrementQuantity(qty) {
    setState(() {
      if (qty > 1) {
        qty--;
      }
    });
  }

  void _removeItem(id, variants) {
    setState(() {
      cart.removeItem(id, variants);
    });
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
              _buildOptionRow("Livraison", "Select Method"),
              _buildOptionRow("Paiement", "🇧🇯"),
              _buildOptionRow("Code promotionnel", "TOTO5"),
              _buildOptionRow("Coût total", "5600 FCFA"),
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
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Commande passée avec succès !")),
                  );
                },
                child:
                    Text("Passer la commande", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
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
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: taille >= 1
            ? Column(children: [
                ListView.builder(
                    itemCount: cart.cartLength,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item = cart.cartItemsList[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "${api_link}/api_fresh/uploads/${item.productImages?[0]}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fitWidth,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${item.productName}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text("${item.quantity}kg, Prix",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        onPressed: () {
                                          print("min");
                                          _decrementQuantity(item.quantity);
                                        }),
                                    Text("${item.quantity}",
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                        icon: Icon(Icons.add_circle_outline),
                                        onPressed: () {
                                          print("plus");
                                          _incrementQuantity(item.quantity);
                                        }),
                                  ],
                                ),
                                Text(
                                    "${item.variants[0].price * item.quantity} FCFA",
                                    style: TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () =>
                                      _removeItem(item.productId, item.variants),
                                ),
                              ],
                            ),
                            Divider(),
                          ],
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
                      _showPaymentModal(context);
                    },
                    child: Text("Aller à la caisse •  ${cart.subtotal} Fcfa",
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ])
            : Column(
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 50,
                  ),
                  Text("Vous n'avez aucun article dans votre panier ${taille}")
                ],
              ),
      ),
    );
  }
}
