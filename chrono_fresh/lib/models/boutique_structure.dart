// To parse this JSON data, do
//
//     final boutique = boutiqueFromJson(jsonString);

import 'dart:convert';

List<Boutique> boutiqueFromJson(String str) => List<Boutique>.from(json.decode(str).map((x) => Boutique.fromJson(x)));

String boutiqueToJson(List<Boutique> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Boutique {
    String? id;
    String? nom;
    String? image;
    String? description;
    String? prix;
    String? stock;
    String? ontop;
    String? categorie;
    String? categoriesSpecifique;
    dynamic createdById;
    dynamic updatedById;
    dynamic deletedById;
    dynamic deletedAt;
    dynamic createdAt;
    dynamic updatedAt;

    Boutique({
        this.id,
        this.nom,
        this.image,
        this.description,
        this.prix,
        this.stock,
        this.ontop,
        this.categorie,
        this.categoriesSpecifique,
        this.createdById,
        this.updatedById,
        this.deletedById,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory Boutique.fromJson(Map<String, dynamic> json) => Boutique(
        id: json["id"],
        nom: json["nom"],
        image: json["image"],
        description: json["description"],
        prix: json["prix"],
        stock: json["stock"],
        ontop: json["ontop"],
        categorie: json["categorie"],
        categoriesSpecifique: json["categories_specifique"],
        createdById: json["created_by_id"],
        updatedById: json["updated_by_id"],
        deletedById: json["deleted_by_id"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "image": image,
        "description": description,
        "prix": prix,
        "stock": stock,
        "ontop": ontop,
        "categorie": categorie,
        "categories_specifique": categoriesSpecifique,
        "created_by_id": createdById,
        "updated_by_id": updatedById,
        "deleted_by_id": deletedById,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
