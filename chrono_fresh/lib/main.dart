import 'dart:io';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:chrono_fresh/acceuil.dart';
import 'package:chrono_fresh/controlleurs/cart_provider.dart';
import 'package:chrono_fresh/pages_login/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var cart = FlutterCart();
  await initializeDateFormatting('fr_FR');
  await cart.initializeCart(isPersistenceSupportEnabled: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHRONO FRESH',
      theme: ThemeData(
        fontFamily: "Roboto",
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          onBackground: Colors.white,
        ).copyWith(background: Colors.white),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      home: const MyHomePage(title: 'CHRONO FRESH'),
      onGenerateRoute: (settings) {
        if (settings.name == 'accueil') {
          final args = settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => Acceuil(
              initialTab: args?['initialTab'] ?? 0,
            ),
          );
        }

        if (settings.name == 'home') {
          return MaterialPageRoute(
            builder: (context) => const MyHomePage(
              title: 'Bienvenue',
            ),
          );
        }

        if (settings.name == 'connect') {
          return MaterialPageRoute(
            builder: (context) => const Connection(),
          );
        }

        // Route inconnue
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = prefs.getString('role');
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          'accueil',
          arguments: {'initialTab': 0},
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image en haut
            Image.asset(
              "assets/fresh.png", // ton image ici
              height: 350,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ligne "CHRONOFRESH"
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "CHRONO",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.normal,
                            color: Colors.black26,
                          ),
                        ),
                        TextSpan(
                          text: "FRESH",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // vert foncé
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Ligne "Vos courses"
                  const Text(
                    "Vos courses",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF00796B),
                    ),
                  ),

                  // Ligne "à portée de clic"
                  const Text(
                    "à portée de clic",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Ligne "Livraison à domicile"
                  const Text(
                    "Livraison à domicile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Boutons en bas
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Bouton principal
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                         Navigator.pushReplacementNamed(context, 'connect');
                      },
                      child: const Text(
                        "Faites vos course",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Bouton secondaire
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.green[700]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                       /* Navigator.pushReplacementNamed(
                      context,
                      'accueil',
                      arguments: {'initialTab': 0},
                    );*/ Navigator.pushReplacementNamed(context, 'accueil');
                      },
                      child: Text(
                        "Decouvrir",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      
    );
  }
}
