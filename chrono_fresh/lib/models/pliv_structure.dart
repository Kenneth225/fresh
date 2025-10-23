// To parse this JSON data, do
//
//     final pliv = plivFromJson(jsonString);

import 'dart:convert';

List<Pliv> plivFromJson(String str) => List<Pliv>.from(json.decode(str).map((x) => Pliv.fromJson(x)));

String plivToJson(List<Pliv> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pliv {
    String? cle;
    String? value;

    Pliv({
        this.cle,
        this.value,
    });

    factory Pliv.fromJson(Map<String, dynamic> json) => Pliv(
        cle: json["cle"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "cle": cle,
        "value": value,
    };
}
