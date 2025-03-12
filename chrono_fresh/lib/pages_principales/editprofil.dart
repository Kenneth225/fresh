import 'package:flutter/material.dart';

class Editprofil extends StatefulWidget {
  const Editprofil({super.key});

  @override
  State<Editprofil> createState() => _EditprofilState();
}

class _EditprofilState extends State<Editprofil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes données"),
        backgroundColor:  Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            //color: Colors.green[700],
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const Column(
                  children: [
                    Text(
                      "Kenneth GABA",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("Registered 5 months ago",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                ProfileField(
                    icon: Icons.phone,
                    label: "Phone number",
                    value: "+229 0196652074"),
                ProfileField(
                    icon: Icons.flag, label: "Pays", value: "Benin"),
                ProfileField(
                    icon: Icons.person, label: "Prénom", value: "Kenneth"),
                ProfileField(
                    icon: Icons.person, label: "Nom", value: "GABA"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Verifié mon email",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text("Enregistrer le changement",
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileField({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: Icon(Icons.edit, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
