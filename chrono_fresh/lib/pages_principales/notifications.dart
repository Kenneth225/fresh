import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationModel {
  final String imageUrl;
  final String title;
  final String subtitle;

  NotificationModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      imageUrl: json['image_url'],
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = fetchNotifications();
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    // Remplace l'URL par celle de ton API PHP
    final response = await http.get(Uri.parse('https://exemple.com/api/notifications'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune notification disponible."));
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final notif = data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notif.imageUrl),
                ),
                title: Text(notif.title),
                subtitle: Text(notif.subtitle),
                onTap: () {
                  // Action quand l'utilisateur clique (optionnel)
                },
              );
            },
          );
        },
      ),
    );
  }
}
