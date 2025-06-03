// To parse this JSON data, do
//
//     final mcommande = mcommandeFromJson(jsonString);

import 'dart:convert';

List<Mcommande> mcommandeFromJson(String str) => List<Mcommande>.from(json.decode(str).map((x) => Mcommande.fromJson(x)));

String mcommandeToJson(List<Mcommande> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mcommande {
    String id;
    DateTime dateCommande;
    String statut;
    String client;
    String iduniq;
    String total;
    String adresse;
    String longitude;
    String latitude;
    String payment;
    String? livreurId;
    dynamic createdById;
    dynamic updatedById;
    dynamic deletedById;
    dynamic deletedAt;
    dynamic createdAt;
    dynamic updatedAt;

    Mcommande({
        required this.id,
        required this.dateCommande,
        required this.statut,
        required this.client,
        required this.iduniq,
        required this.total,
        required this.adresse,
        required this.longitude,
        required this.latitude,
        required this.payment,
        required this.livreurId,
        required this.createdById,
        required this.updatedById,
        required this.deletedById,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Mcommande.fromJson(Map<String, dynamic> json) => Mcommande(
        id: json["id"],
        dateCommande: DateTime.parse(json["date_commande"]),
        statut: json["statut"],
        client: json["client"],
        iduniq: json["iduniq"],
        total: json["total"],
        adresse: json["adresse"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        payment: json["payment"],
        livreurId: json["livreur_id"],
        createdById: json["created_by_id"],
        updatedById: json["updated_by_id"],
        deletedById: json["deleted_by_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date_commande": "${dateCommande.year.toString().padLeft(4, '0')}-${dateCommande.month.toString().padLeft(2, '0')}-${dateCommande.day.toString().padLeft(2, '0')}",
        "statut": statut,
        "client": client,
        "iduniq": iduniq,
        "total": total,
        "adresse": adresse,
        "longitude": longitude,
        "latitude": latitude,
        "payment": payment,
        "livreur_id": livreurId,
        "created_by_id": createdById,
        "updated_by_id": updatedById,
        "deleted_by_id": deletedById,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
