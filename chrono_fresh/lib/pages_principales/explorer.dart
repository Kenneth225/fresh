import 'dart:math';

import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

 final List<Map<String, String>> categories = const [
    {'title': 'Poissons fraîches', 'image': 'assets/fish.png'},
    {'title': 'Viandes', 'image': 'assets/meat.png'},
    {'title': 'Viandes et poissons', 'image': 'assets/mixed.png'},
    {'title': 'Lorem', 'image': 'assets/lorem.png'},
    {'title': 'Lorem', 'image': 'assets/lorem2.png'},
    {'title': 'Viande rouge', 'image': 'assets/red_meat.png'},
  ];

Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(200) + 50,
      random.nextInt(200) + 50,
      random.nextInt(200) + 50,
    ).withOpacity(0.2);
  }

class _ExplorerState extends State<Explorer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Trouver des produits")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher dans le magasin',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vous avez sélectionné ${category['title']}')),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: getRandomColor(),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category['image']!,
                            height: 60,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['title']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),)
    );
  }
}
