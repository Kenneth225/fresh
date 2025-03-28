import 'package:flutter/material.dart';

class Suivicommande extends StatefulWidget {
  const Suivicommande({super.key});

  @override
  State<Suivicommande> createState() => _SuivicommandeState();
}

class _SuivicommandeState extends State<Suivicommande> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Suivre la commande'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStep(
              icon: Icons.receipt_long,
              title: 'Commande prise',
              isCompleted: true,
            ),
            OrderStep(
              icon: Icons.kitchen,
              title: 'La commande est en cours de préparation',
              isCompleted: true,
            ),
            OrderStep(
              icon: Icons.delivery_dining,
              title: 'Livraison en cours',
              subtitle: 'Le livreur est en route',
              isCompleted: false,
              showCallIcon: true,
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Center(child: Text('Carte ici', style: TextStyle(color: Colors.black54))),
            ),
            SizedBox(height: 10),
            OrderStep(
              icon: Icons.check_circle,
              title: 'Commande reçue',
              isCompleted: true,
              isFinalStep: true,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool showCallIcon;
  final bool isFinalStep;

  OrderStep({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.showCallIcon = false,
    this.isFinalStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: isCompleted ? Colors.green : Colors.orange, size: 30),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ),
        if (isCompleted)
          Icon(Icons.check_circle, color: Colors.green),
        if (showCallIcon)
          Icon(Icons.call, color: Colors.orange),
      ],
    );
  }
}