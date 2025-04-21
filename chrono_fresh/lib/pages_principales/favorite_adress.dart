import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteAddressesPage extends StatefulWidget {
  const FavoriteAddressesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteAddressesPage> createState() => _FavoriteAddressesPageState();
}

class _FavoriteAddressesPageState extends State<FavoriteAddressesPage> {
  List<Map<String, String>> favoriteAddresses = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  int? editingIndex;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favorite_addresses');
    if (data != null) {
      final decoded = json.decode(data) as List;
      setState(() {
        favoriteAddresses =
            decoded.map((e) => Map<String, String>.from(e)).toList();
      });
    }
  }

  Future<void> _saveAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorite_addresses', json.encode(favoriteAddresses));
  }

  void _showAddressForm({int? index}) {
    if (index != null) {
      _nameController.text = favoriteAddresses[index]['name']!;
      _addressController.text = favoriteAddresses[index]['address']!;
      editingIndex = index;
    } else {
      _nameController.clear();
      _addressController.clear();
      editingIndex = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                editingIndex != null ? "Modifier l'adresse" : "Nouvelle adresse",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nom de l'adresse"),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Adresse"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Veuillez remplir tous les champs.")),
                    );
                    return;
                  }

                  final newEntry = {
                    'name': _nameController.text,
                    'address': _addressController.text,
                  };

                  setState(() {
                    if (editingIndex != null) {
                      favoriteAddresses[editingIndex!] = newEntry;
                      editingIndex = null;
                    } else {
                      if (favoriteAddresses.length >= 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Limite de 3 adresses atteinte.")),
                        );
                        return;
                      }
                      favoriteAddresses.add(newEntry);
                    }
                  });

                  _saveAddresses();
                  Navigator.of(context).pop();
                },
                child: Text(editingIndex != null ? 'Modifier' : 'Ajouter'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _deleteAddress(int index) {
    setState(() {
      favoriteAddresses.removeAt(index);
    });
    _saveAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mes adresses favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: favoriteAddresses.isEmpty
            ? const Center(child: Text("Aucune adresse enregistrée."))
            : ListView.builder(
                itemCount: favoriteAddresses.length,
                itemBuilder: (context, index) {
                  final item = favoriteAddresses[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(item['name']!),
                      subtitle: Text(item['address']!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showAddressForm(index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteAddress(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddressForm(),
        tooltip: 'Ajouter une adresse',
        child: const Icon(Icons.add),
      ),
    );
  }
}
