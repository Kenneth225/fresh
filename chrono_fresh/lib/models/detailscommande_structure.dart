// To parse this JSON data, do
//
//     final dcom = dcomFromJson(jsonString);

import 'dart:convert';

List<Dcom> dcomFromJson(String str) => List<Dcom>.from(json.decode(str).map((x) => Dcom.fromJson(x)));

String dcomToJson(List<Dcom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dcom {
    String? id;
    String? image;
    String? idCommande;
    String? idProduit;
    String? nom;
    String? quantite;
    String? prixUnitaire;
    dynamic createdById;
    dynamic updatedById;
    dynamic deletedById;
    dynamic deletedAt;
    dynamic createdAt;
    dynamic updatedAt;

    Dcom({
        this.id,
        this.image,
        this.idCommande,
        this.idProduit,
        this.nom,
        this.quantite,
        this.prixUnitaire,
        this.createdById,
        this.updatedById,
        this.deletedById,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Dcom.fromJson(Map<String, dynamic> json) => Dcom(
        id: json["id"],
        image: json["image"],
        idCommande: json["id_commande"],
        idProduit: json["id_produit"],
        nom: json["nom"],
        quantite: json["quantite"],
        prixUnitaire: json["prix_unitaire"],
        createdById: json["created_by_id"],
        updatedById: json["updated_by_id"],
        deletedById: json["deleted_by_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "id_commande": idCommande,
        "id_produit": idProduit,
        "nom": nom,
        "quantite": quantite,
        "prix_unitaire": prixUnitaire,
        "created_by_id": createdById,
        "updated_by_id": updatedById,
        "deleted_by_id": deletedById,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
