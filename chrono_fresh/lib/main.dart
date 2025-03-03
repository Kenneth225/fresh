import 'package:chrono_fresh/acceuil.dart';
import 'package:chrono_fresh/pages_login/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
     var cart = FlutterCart();
     await cart.initializeCart(isPersistenceSupportEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Roboto",
          useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.green).copyWith(background: Colors.white),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: 'home',
        routes: {
          'home': (context) => const MyHomePage(
                title: 'Bienvenue',
              ),
          'accueil': (context) => Acceuil(),
          'connect':(context) => connection()
        });
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
  String mail = '';

  void initState() {
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('usermail');

    if (mail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail!;
      });
      Navigator.pushReplacementNamed(context, 'accueil');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   /*   appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),*/
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
               gradient: LinearGradient(colors: [
                          Color.fromRGBO(208, 208, 208, 0.667),
                          Color.fromRGBO(60, 60, 60, 1),
                        ]),
              image: DecorationImage(
                opacity: 10,
                  image: AssetImage("assets/home.jpeg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 420.25),
            child: Column(
              children: [
                const Text(
                  "Bienvenue dans notre magazin",textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.normal),
                ),
                const Text("Faites vos courses sans vous deplacer",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
                Center(
                  child: Container(
                    height: 55,
                    //width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(14, 232, 62, 0.667),
                          Color.fromRGBO(70, 225, 106, 1),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'accueil');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Commencer",
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
                ),
                SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 55,
                    //width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(14, 209, 223, 0.667),
                          Color.fromRGBO(87, 118, 192, 1),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'connect');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Connectez vous",
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
                ),
              ],
            ),
          )),
    );
  }
}
