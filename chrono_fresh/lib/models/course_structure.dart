// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    String id;
    String idLivreur;
    String idCommande;
    String livCourse;
    dynamic longitude;
    dynamic latitude;
    dynamic test;
    String finCourse;

    Course({
        required this.id,
        required this.idLivreur,
        required this.idCommande,
        required this.livCourse,
        required this.longitude,
        required this.latitude,
        required this.test,
        required this.finCourse,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        idLivreur: json["id_livreur"],
        idCommande: json["id_commande"],
        livCourse: json["liv_course"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        test: json["test"],
        finCourse: json["fin_course"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_livreur": idLivreur,
        "id_commande": idCommande,
        "liv_course": livCourse,
        "longitude": longitude,
        "latitude": latitude,
        "test": test,
        "fin_course": finCourse,
    };
}
