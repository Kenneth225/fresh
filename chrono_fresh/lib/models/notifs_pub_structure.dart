// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) => List<Notifications>.from(json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
    String? id;
    String? titre;
    String? sousTitre;
    String? image;
    dynamic lien;
    dynamic createdAt;
    dynamic updatedAt;

    Notifications({
        this.id,
        this.titre,
        this.sousTitre,
        this.image,
        this.lien,
        this.createdAt,
        this.updatedAt,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        titre: json["titre"],
        sousTitre: json["sous-titre"],
        image: json["image"],
        lien: json["lien"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "sous-titre": sousTitre,
        "image": image,
        "lien": lien,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
