import 'package:flutter/material.dart';

class Mescommandes extends StatefulWidget {
  const Mescommandes({super.key});

  @override
  State<Mescommandes> createState() => _MescommandesState();
}

class Order {
  final String number;
  final String name;
  final String date;
  final String total;
  final String status;
  final Color statusColor;

  Order({
    required this.number,
    required this.name,
    required this.date,
    required this.total,
    required this.status,
    required this.statusColor,
  });
}

class _MescommandesState extends State<Mescommandes> {
  @override
  final List<Order> orders = [
    Order(
      number: "1658893",
      name: "Royal Panini's Guincomey 🌯",
      date: "13 Dec at 18:06",
      total: "2750 F",
      status: "Order delivered",
      statusColor: Colors.green,
    ),
    Order(
      number: "1658794",
      name: "Royal Panini's Guincomey 🌯",
      date: "13 Dec at 17:21",
      total: "2750 F",
      status: "Cancelled",
      statusColor: Colors.red,
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Mes Commandes",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "December 2024",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/viande.jpeg', // Remplace cette image par la tienne
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("N° 1658794",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              SizedBox(height: 4),
                              Text("Royal Panini's Guincomey 🌯",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("1 article · Total : 2750 F",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              SizedBox(height: 4),
                              Text("13 Dec at 17:21",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text("Cancelled",
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
                ;
              },
            ),
          ),
        ],
      ),
    );
  }
}
