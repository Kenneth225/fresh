import 'package:chrono_fresh/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String? id;
  String? nom;
  String? prix;
  String? description;
  String? categorie;
  String? image;
  String? stock;
  /* String? idVendeur;
  String? statut;
  String? qtreduc;
  String? mtreduc;*/

  Details({
    super.key,
    this.id,
    this.nom,
    this.prix,
    this.description,
    this.categorie,
    this.image,
    this.stock,
    /* this.idVendeur,
      this.statut,
      this.qtreduc,
      this.mtreduc*/
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
    print("okkkkkkk");
  }

  int quantity = 1;
  var cart = FlutterCart();
  bool isLoggedIn = false;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;

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
              child: const Text("Se connecté"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
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

  commande_fict(id, nom, image, int qt, prix, mode) async {
    cart.addToCart(
        cartModel: CartModel(
            productId: id,
            productName: nom,
            productImages: [image],
            quantity: qt,
            variants: [
              ProductVariant(price: double.parse(prix)),
            ],
            //discount: double.parse(prix),
            productDetails: mode));

    const snackBar = SnackBar(
      backgroundColor: Color.fromARGB(255, 131, 230, 167),
      content: Text('Consulter votre panier'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(cart.cartLength);
    print(cart.subtotal);
    print(cart.total);

    //Navigator.pushReplacementNamed(context, 'accueil');
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.backspace_outlined)),
        actions: [
          Icon(Icons.ios_share_rounded),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              "${api_link}/api_fresh/uploads/${widget.image}",
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            Row(
              children: [
                Text(
                  "${widget.nom}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 27),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                ),
                const Icon(Icons.favorite_border_outlined)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${widget.stock}kg, Prix",
              style: const TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity = quantity - 1;
                      });
                    },
                    icon: const Icon(Icons.minimize)),
                Container(
                  width: 30,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "${quantity}",
                        fillColor: Colors.white,
                        hoverColor: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity = quantity + 1;
                      });
                    },
                    icon: const Icon(Icons.add_outlined)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                ),
                Text(
                  "${widget.prix} Fcfa",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 27),
                ),
              ],
            ),
            const Divider(),
             ExpansionTile(
              title: const Text(
                'Détail du produit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    "${widget.description}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const Divider(),
            ExpansionTile(
              title: const Text(
                'Recettes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [Text('blablabal')],
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Notes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 20,
                  ),
                )..add(const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                    size: 20,
                  )),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print(isLoggedIn);
                  if (isLoggedIn) {
                    commande_fict(widget.id, widget.nom, widget.image, quantity,
                        widget.prix, widget.description);
                  } else {
                    _showMyDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Ajouter au panier',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
