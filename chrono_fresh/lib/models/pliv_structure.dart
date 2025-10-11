// To parse this JSON data, do
//
//     final pliv = plivFromJson(jsonString);

import 'dart:convert';

List<Pliv> plivFromJson(String str) => List<Pliv>.from(json.decode(str).map((x) => Pliv.fromJson(x)));

String plivToJson(List<Pliv> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pliv {
    String? id;
    String? prix;

    Pliv({
        this.id,
        this.prix,
    });

    factory Pliv.fromJson(Map<String, dynamic> json) => Pliv(
        id: json["id"],
        prix: json["prix"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
    };
}
