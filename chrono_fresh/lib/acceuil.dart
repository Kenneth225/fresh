import 'package:chrono_fresh/pages_principales/resultat_recette.dart';
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
    Profil(),
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

    // ✅ Sécurisation pour éviter RangeError
    if (_tabNum >= _tabsUser.length) {
      _tabNum = 0;
    }

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

  var cart = FlutterCart();

  @override
  Widget build(BuildContext context) {
    final bool isLivreur = _role == "2";
    final tabs = isLivreur ? _tabsLivreur : _tabsUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoggedIn ? tabs[_tabNum] : _tabsUser[_tabNum],
      bottomNavigationBar: _isLoggedIn
    ? LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          final isVerySmall = screenWidth < 350;
          final isSmallScreen = screenWidth < 400;
          final isTablet = screenWidth > 600;

          // Adjust icon and text sizes responsively
          final baseIconSize =
              isVerySmall ? 20.0 : (isSmallScreen ? 20.0 : (isTablet ? 28.0 : 23.0));
          final baseTextSize =
              isVerySmall ? 10.0 : (isSmallScreen ? 12.0 : (isTablet ? 20.0 : 14.0));

          final paddingV = isTablet ? 25.0 : 17.0;
          final paddingH = isTablet ? screenWidth * 0.05 : screenWidth * 0.03;

          return SafeArea(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: paddingH,
                vertical: paddingV,
              ),
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, _) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: GNav(
                      backgroundColor: Colors.white,
                      style: GnavStyle.oldSchool,
                      color: Colors.black,
                      activeColor: const Color(0xFF006650),
                      selectedIndex: _tabNum,
                      padding: EdgeInsets.all(isTablet ? 14 : 10),
                      gap: isTablet ? 8 : 5,
                      iconSize: baseIconSize,
                      onTabChange: (index) {
                        setState(() {
                          _tabNum = index;
                        });
                      },
                      tabs: isLivreur
                          ? [
                              GButton(
                                icon: Icons.auto_graph_outlined,
                                text: 'Statistique',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon: Icons.motorcycle_rounded,
                                text: 'Courses',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon: Icons.person_4_outlined,
                                text: 'Compte',
                                textSize: baseTextSize,
                              ),
                            ]
                          : [
                              GButton(
                                icon: Icons.local_convenience_store_rounded,
                                text: 'Home',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon: Icons.travel_explore_rounded,
                                text: 'Explorer',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon:Icons.shopping_cart_outlined,
                                leading: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(Icons.shopping_cart, size: baseIconSize + 5),
                                    if (cart.cartLength > 0)
                                      Positioned(
                                        right: -6,
                                        top: -6,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 20,
                                            minHeight: 20,
                                          ),
                                          child: Text(
                                            '${cartProvider.cartItemCount}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isTablet ? 14 : 11,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                text: 'Panier',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon: Icons.soup_kitchen_outlined,
                                text: 'Recettes',
                                textSize: baseTextSize,
                              ),
                              GButton(
                                icon: Icons.person_4_outlined,
                                text: 'Profil',
                                textSize: baseTextSize,
                              ),
                            ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
    : null,

    );
  }
}
