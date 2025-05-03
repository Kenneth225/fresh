import 'package:chrono_fresh/controlleurs/searchbar_api.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Charger les produits depuis le serveur et les stocker localement
    fetchAndStoreProducts();
  }

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  void searchProduct(String query) async {
    final results = await dbHelper.searchProducts(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Recherche'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Rechercher un produit',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (value) {
                  searchProduct(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchResults[index];
                  return GestureDetector(
                    onTap: () {
                     /* Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Details(
                                id: product['id'],
                                nom: product['name'],
                                prix: product['price'],
                                description: product['desc'],
                                categorie: product['cat'],
                                image: product['img'],
                              )));*/
                    },
                    child: ListTile(
                      leading: Icon(Icons.search_off_outlined),
                      title: Text(
                        product['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      // subtitle: Text('Prix: ${product['price']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
