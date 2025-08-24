
import 'package:chrono_fresh/setup/mon_compte.dart';
import 'package:chrono_fresh/setup/resultat_recette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cart/cart.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/livreur/statistiques.dart';
import 'package:chrono_fresh/livreur/courses.dart';
import 'package:chrono_fresh/pages_principales/boutique.dart';
import 'package:chrono_fresh/pages_principales/explorer.dart';
import 'package:chrono_fresh/pages_principales/panier.dart';
import 'package:chrono_fresh/pages_principales/profil.dart';

class Acceuil extends StatefulWidget {
  final int initialTab;

  const Acceuil({super.key, this.initialTab = 0});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  int _tabNum = 0;
  String _role = '';
  bool _isLoggedIn = false;

  final List<Widget> _tabsUser = const [
    boutique(),
    Explorer(),
    Panier(),
    ReSultatsCateGorieRecette(),
    MonCompte()
    //Profil(),
  ];

  final List<Widget> _tabsLivreur = const [
    Statistique(),
    Courses(),
    Profil(),
  ];

  @override
  void initState() {
    super.initState();
    _tabNum = widget.initialTab;
    _autoLogIn();
  }

  Future<void> _autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    final usermail = prefs.getString('email');
    final roli = prefs.getString('role');

    if (usermail != null && roli != null) {
      setState(() {
        _isLoggedIn = true;
        _role = roli;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLivreur = _role == "2";

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoggedIn
          ? (isLivreur ? _tabsLivreur[_tabNum] : _tabsUser[_tabNum])
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _isLoggedIn
          ? Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, _) {
                  return GNav(
                    backgroundColor: Colors.white,
                    style: GnavStyle.google,
                    color: Colors.black,
                    activeColor: const Color.fromARGB(255, 36, 246, 117),
                    selectedIndex: _tabNum,
                    gap: 5,
                    padding: const EdgeInsets.all(8),
                    onTabChange: (index) {
                      setState(() {
                        _tabNum = index;
                      });
                    },
                    tabs: isLivreur
                        ? const [
                            GButton(
                              icon: Icons.auto_graph_outlined,
                              text: 'Statistique',
                            ),
                            GButton(
                              icon: Icons.motorcycle_rounded,
                              text: 'Courses',
                            ),
                            GButton(
                              icon: Icons.person_4_outlined,
                              text: 'Compte',
                            ),
                          ]
                        : [
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
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(Icons.shopping_cart, size: 30),
                                    if (cartProvider.cartItemCount > 0)
                                      Positioned(
                                        right: -6,
                                        top: -6,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Text(
                                            '${cartProvider.cartItemCount}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              icon: Icons.shopping_cart_outlined,
                              text: 'Panier',
                            ),
                            const GButton(
                              icon: Icons.soup_kitchen_outlined,
                              text: 'Recettes',
                            ),
                            const GButton(
                              icon: Icons.person_4_outlined,
                              text: 'Compte',
                            ),
                          ],
                  );
                },
              ),
            )
          : null,
    );
  }
}
