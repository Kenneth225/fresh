// To parse this JSON data, do
//
//     final zones = zonesFromJson(jsonString);

import 'dart:convert';

List<Zones> zonesFromJson(String str) => List<Zones>.from(json.decode(str).map((x) => Zones.fromJson(x)));

String zonesToJson(List<Zones> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Zones {
    String? id;
    String? idClient;
    String? name;
    String? longitude;
    String? latitude;
    dynamic createdAt;
    dynamic updatedAt;

    Zones({
        this.id,
        this.idClient,
        this.name,
        this.longitude,
        this.latitude,
        this.createdAt,
        this.updatedAt,
    });

    factory Zones.fromJson(Map<String, dynamic> json) => Zones(
        id: json["id"],
        idClient: json["id_client"],
        name: json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
