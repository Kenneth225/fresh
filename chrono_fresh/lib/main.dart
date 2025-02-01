import 'package:chrono_fresh/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        initialRoute: 'home',
        routes: {
          'home': (context) => const MyHomePage(
                title: 'Bienvenue',
              ),
          'accueil': (context) => Acceuil(),
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
  String numero = '';

  void initState() {
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usernum = prefs.getString('telephone');

    if (usernum != null) {
      setState(() {
        isLoggedIn = true;
        numero = usernum;
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
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/moon.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 420.25),
            child: Column(
              children: [
                Text(
                  "Bienvenue dans notre magazin",textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.normal),
                ),
                Text("Faites vos courses sans vous deplacer",textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
                Center(
                  child: Container(
                    height: 55,
                    //width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(14, 232, 62, 0.667),
                          Color.fromRGBO(70, 225, 106, 1),
                        ])),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'accueil');
                        },
                        child: Row(
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
              ],
            ),
          )),
    );
  }
}
