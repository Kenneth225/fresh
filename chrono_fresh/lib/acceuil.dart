import 'package:chrono_fresh/pages_principales/boutique.dart';
import 'package:chrono_fresh/pages_principales/explorer.dart';
import 'package:chrono_fresh/pages_principales/panier.dart';
import 'package:chrono_fresh/pages_principales/profil.dart';
import 'package:chrono_fresh/pages_principales/recettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

bool loged = true;
int _tabNum = 0;
var cart = FlutterCart();
final _tab = [
  const boutique(),
  const Explorer(),
  const Panier(),
  const Recettes(),
  const Profil()
];
final _tab2 = [const boutique(), const Profil()];

class _AcceuilState extends State<Acceuil> {
  bool isLoggedIn = false;
  String mail = '';
  String role = "1";
  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('usermail');
    // final String? role = prefs.getString('role');

    setState(() {
      isLoggedIn = true;
      mail = usermail!;
      // role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: role == "1" ? _tab[_tabNum] : _tab2[_tabNum],
        //child: _tab[_tabNum],
      ),
      bottomNavigationBar: Container(
        //width: MediaQuery.of(context).size.height * 1.1,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            style: GnavStyle.google,
            //iconSize: 12,
            textSize: 9,
            color: Color.fromARGB(255, 11, 11, 11),
            //tabBackgroundColor: Colors.white,
            activeColor: Color.fromARGB(255, 36, 246, 117),
            selectedIndex: _tabNum,
            gap: 5,
            padding: EdgeInsets.all(8),
            tabs: role == "1"
                ? [
                    const GButton(
                      icon: Icons.local_convenience_store_rounded,
                      text: 'Boutique',
                    ),
                    const GButton(
                      icon: Icons.travel_explore_rounded,
                      text: 'Explorer',
                    ),
                    GButton(
                       leading: Stack(
                        children: <Widget>[
                          const Icon(Icons.shopping_cart, size: 30),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cart.cartLength}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                      icon: Icons.shopping_cart_outlined,
                      text: 'Panier',
                    ),
                    /*  GButton(icon: Icons.favorite_border_outlined, text: 'Favoris'),*/
                    GButton(
                        icon: Icons.soup_kitchen_outlined, text: 'Recettes'),
                    GButton(icon: Icons.person_4_outlined, text: 'Compte'),
                  ]
                : const [
                    GButton(
                      icon: Icons.local_convenience_store_rounded,
                      text: 'Boutique',
                    ),
                    GButton(icon: Icons.person_4_outlined, text: 'Compte'),
                  ],
            onTabChange: (index) {
              setState(() {
                _tabNum = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
