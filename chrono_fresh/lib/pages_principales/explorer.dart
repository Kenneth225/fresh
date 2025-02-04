import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Trouver des produits")),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            child: Container(
              color: Colors.white,
              height: 230,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        /*if (statut == "wait") {
                          verification();
                        } else {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => new Party()));
                        }*/
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          "assets/fish.png",
                          height: 100,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Cérémonie",
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("1kg,Prix"),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("1400 fcfa"),
                        Container(
                          height: 35,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(14, 232, 62, 0.667),
                                Color.fromRGBO(70, 225, 106, 1),
                              ])),
                          child: Center(
                            child: TextButton(
                              onPressed: () {},
                              child: const Row(
                                verticalDirection: VerticalDirection.up,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "+",
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
