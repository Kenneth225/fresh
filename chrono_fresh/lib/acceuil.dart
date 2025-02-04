import 'package:chrono_fresh/pages_principales/boutique.dart';
import 'package:chrono_fresh/pages_principales/explorer.dart';
import 'package:chrono_fresh/pages_principales/favoris.dart';
import 'package:chrono_fresh/pages_principales/panier.dart';
import 'package:chrono_fresh/pages_principales/profil.dart';
import 'package:chrono_fresh/pages_principales/recettes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

bool loged = true;
int _tabNum = 0;
final _tab = [boutique(), Explorer(), Panier(),  Recettes(), Profil()];
//final _tab2 = [new Mesconsults(), new Allconsults(), new Doneconsults(), new Profil()];

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // child: role == "2" ?_tab2[_tabNum] : _tab[_tabNum],
        child: _tab[_tabNum],
      ),
      bottomNavigationBar: Container(
        //width: MediaQuery.of(context).size.height * 1.1,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            style: GnavStyle.google,
            //iconSize: 12,
            textSize: 9,
            color: Color.fromARGB(255, 11, 11, 11),
            //tabBackgroundColor: Colors.white,
            activeColor: Color.fromARGB(255, 36, 246, 117),
            selectedIndex: _tabNum,
            gap: 4,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.local_convenience_store_rounded,
                text: 'Boutique',
              ),
              GButton(
                icon: Icons.travel_explore_rounded,
                text: 'Explorer',
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: 'Panier',
              ),
            /*  GButton(icon: Icons.favorite_border_outlined, text: 'Favoris'),*/
              GButton(icon: Icons.soup_kitchen_outlined, text: 'Recettes'),
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
