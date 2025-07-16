// To parse this JSON data, do
//
//     final categorie = categorieFromJson(jsonString);

import 'dart:convert';

List<Categorie> categorieFromJson(String str) => List<Categorie>.from(json.decode(str).map((x) => Categorie.fromJson(x)));

String categorieToJson(List<Categorie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categorie {
    String id;
    String nomCategorie;
    String visuel;
    String ontop;

    Categorie({
        required this.id,
        required this.nomCategorie,
        required this.visuel,
        required this.ontop,
    });

    factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
        id: json["id"],
        nomCategorie: json["nom_categorie"],
        visuel: json["visuel"],
        ontop: json["ontop"],
    ); 

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom_categorie": nomCategorie,
        "visuel": visuel,
        "ontop": ontop,
    };
}
