import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String? id;
  String? nom;
  String? prix;
  String? description;
  String? categorie;
  String? image;
  String? stock;
  /* String? idVendeur;
  String? statut;
  String? qtreduc;
  String? mtreduc;*/

  Details({
    super.key,
    this.id,
    this.nom,
    this.prix,
    this.description,
    this.categorie,
    this.image,
    this.stock,
    /* this.idVendeur,
      this.statut,
      this.qtreduc,
      this.mtreduc*/
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.backspace_outlined)),
        actions: [
          Icon(Icons.ios_share_rounded),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            "https://demoalito.mydevcloud.com/waxbank/assets/uploads/images/${widget.image}",
            height: 300,
            fit: BoxFit.fitWidth,
          ),
          Row(
            children: [
              Text(
                "${widget.nom}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
              ),
              const Icon(Icons.favorite_border_outlined)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "${widget.stock}kg, Prix",
            style: const TextStyle(fontSize: 17, color: Colors.black45),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity = quantity - 1;
                    });
                  },
                  icon: const Icon(Icons.minimize)),
              Container(
                width: 30,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "${quantity}",
                      fillColor: Colors.white,
                      hoverColor: Colors.white),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      quantity = quantity + 1;
                    });
                  },
                  icon: const Icon(Icons.add_outlined)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
              ),
              Text(
                "${widget.prix} Fcfa",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
              ),
            ],
          ),
          const Divider(),
          const ExpansionTile(
            title: Text(
              'Détail du produit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Le Poulet Est Une Excellente Source De Protéines Maigres, Idéale Pour La Construction Musculaire Et La Perte De Poids. Riche En Vitamines Et Minéraux, Il Soutient Également La Santé Du Cœur Et Du Système Immunitaire.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: const Text(
              'Recettes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [Text('blablabal')],
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Notes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 20,
                ),
              )..add(const Icon(
                  Icons.star_half,
                  color: Colors.orange,
                  size: 20,
                )),
            ),
            onTap: () {},
          ),

const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Ajouter au panier',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
