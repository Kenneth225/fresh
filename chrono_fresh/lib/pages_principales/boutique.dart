import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class boutique extends StatefulWidget {
  const boutique({super.key});

  @override
  State<boutique> createState() => _boutiqueState();
}

class _boutiqueState extends State<boutique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(59, 59, 59, 1),
                ),
                Text("Akpakpa, Cotonou")
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: GestureDetector(
                  onTap: () {},
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(59, 59, 59, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Rechercher dans le magasin",
                        fillColor: Colors.white,
                        hoverColor: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(items: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          "assets/slide.jpeg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      /*ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          "assets/moon.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),*/
                    ], options: CarouselOptions(autoPlay: true)),
                  ]),
            ),
            const Text("Poisson"),
            Row(
              children: [
                Card(
                  color: Colors.black,
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
                              child: Image.network(
                                "http://demoalito.mydevcloud.com/api_tissu/uploads/ceremonie.jpg",
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
          ],
        ),
      ),
    );
  }
}
