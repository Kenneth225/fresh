// To parse this JSON data, do
//
//     final mrecettes = mrecettesFromJson(jsonString);

import 'dart:convert';

List<Mrecettes> mrecettesFromJson(String str) => List<Mrecettes>.from(json.decode(str).map((x) => Mrecettes.fromJson(x)));

String mrecettesToJson(List<Mrecettes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mrecettes {
    String id;
    String nomPlat;
    String image;
    String ingredient;
    String duree;
    String description;
    String produitAssocie;

    Mrecettes({
        required this.id,
        required this.nomPlat,
        required this.image,
        required this.ingredient,
        required this.duree,
        required this.description,
        required this.produitAssocie,
    });

    factory Mrecettes.fromJson(Map<String, dynamic> json) => Mrecettes(
        id: json["id"],
        nomPlat: json["nom_plat"],
        image: json["image"],
        ingredient: json["ingredient"],
        duree: json["duree"],
        description: json["description"],
        produitAssocie: json["produitAssocie"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom_plat": nomPlat,
        "image": image,
        "ingredient": ingredient,
        "duree": duree,
        "description": description,
        "produitAssocie": produitAssocie,
    };
}
