import 'package:flutter/material.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

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
          const Divider(
            height: 2,
          ),
          Center(
            child: TapToExpand(
              //backgroundcolor: Theme.of(context).colorScheme.surface,
              curve: Curves.easeIn,
              content: Column(
                children: <Widget>[
                  for (var i = 0; i < 20; i++)
                    Text(
                      "data $i",
                    ),
                ],
              ),
              title: Row(
                children: [
                  Text(
                    'TapToExpand',
                  ),
                  Icon(Icons.arrow_drop_down_circle_outlined)
                ],
              ),
              closedHeight: 70,
              borderRadius: BorderRadius.circular(10),
              openedHeight: 200,
            ),
          )
        ],
      ),
    );
  }
}
