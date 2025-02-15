// To parse this JSON data, do
//
//     final boutique = boutiqueFromJson(jsonString);

import 'dart:convert';

List<Boutique> boutiqueFromJson(String str) => List<Boutique>.from(json.decode(str).map((x) => Boutique.fromJson(x)));

String boutiqueToJson(List<Boutique> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Boutique {
    String id;
    String nom;
    String image;
    String description;
    String prix;
    String categorie;
    String stock;

    Boutique({
        required this.id,
        required this.nom,
        required this.image,
        required this.description,
        required this.prix,
        required this.categorie,
        required this.stock,
    });

    factory Boutique.fromJson(Map<String, dynamic> json) => Boutique(
        id: json["id"],
        nom: json["nom"],
        image: json["image"],
        description: json["description"],
        prix: json["prix"],
        categorie: json["categorie"],
        stock: json["stock"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "image": image,
        "description": description,
        "prix": prix,
        "categorie": categorie,
        "stock": stock,
    };
}
