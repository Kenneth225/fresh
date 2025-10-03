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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/fresh.png",
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 420.25),
            child: Column(
              children: [
                const Text(
                  "Bienvenue dans notre magasin",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const Text(
                  "Faites vos courses sans vous déplacer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 24),
                _buildButton(
                  label: "Commencer",
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(14, 232, 62, 0.667),
                      Color.fromRGBO(70, 225, 106, 1),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'accueil',
                      arguments: {'initialTab': 0},
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildButton(
                  label: "Connectez-vous",
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(14, 209, 223, 0.667),
                      Color.fromRGBO(87, 118, 192, 1),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'connect');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required LinearGradient gradient,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: gradient,
          ),
          child: Center(
            child: TextButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
