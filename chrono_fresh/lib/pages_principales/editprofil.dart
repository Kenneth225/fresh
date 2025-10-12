import 'dart:convert';
import 'dart:io';
import 'package:chrono_fresh/global_var.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String? _imagePath;
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _mail = '';
  String? nom;
  String? prenom;
  String? role;
  String? avatar;
  String? telephone;
  String? mail;
  String? id;
  bool isLoggedIn = false;
  bool load = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usermail = prefs.getString('email');
    String? role = prefs.getString('role');

    if (usermail != null) {
      setState(() {
        isLoggedIn = true;
        mail = usermail;
        role = role!;
        nom = prefs.getString('nom');
        prenom = prefs.getString('prenom');
        telephone = prefs.getString('telephone');
        id = prefs.getString('id');
      });
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('user_image');
      _firstName = prefs.getString('prenom') ?? '';
      _lastName = prefs.getString('nom') ?? '';
      _phone = prefs.getString('telephone') ?? '';
      _mail = mail ?? '';
    });
  }

  Future<void> _saveUserData(idcli, prenom, nom, mail, tel) async {
    if (_imagePath != null) {

      var url = Uri.parse("${api_link}/api_fresh/editprofil.php");
      
    var request = http.MultipartRequest('POST', url);
    
    var pic = await http.MultipartFile.fromPath('image', _imagePath!);
    request.files.add(pic);
    //var response = await request.send();
    
    var data = {
      "idc": idcli,
      "prenom": prenom,
      "nom": nom,
      "Email": mail,
      "phone": tel,
      "avatar": _imagePath!
    };
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('prenom', _firstName);
      await prefs.setString('nom', _lastName);
      await prefs.setString('telephone', _phone);
      await prefs.setString('email', _mail);
      if (_imagePath != null) {
        await prefs.setString('user_image', _imagePath!);
      }

      Fluttertoast.showToast(
          msg: "Merci,  pris en compte",
          toastLength: Toast.LENGTH_LONG);
    }  else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
      
    } else {

      var url = Uri.parse("${api_link}/api_fresh/editprofil.php");
    
    var data = {
      "idc": idcli,
      "prenom": prenom,
      "nom": nom,
      "Email": mail,
      "phone": tel,
      
    };
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('prenom', _firstName);
      await prefs.setString('nom', _lastName);
      await prefs.setString('telephone', _phone);
      await prefs.setString('email', _mail);
      if (_imagePath != null) {
        await prefs.setString('user_image', _imagePath!);
      }

      Fluttertoast.showToast(
          msg: "Merci,  pris en compte",
          toastLength: Toast.LENGTH_LONG);
    }  else {
      Fluttertoast.showToast(
          msg: "Erreur de connexion", toastLength: Toast.LENGTH_LONG);
    }
      
    }
    
  }

  void _openEditModal() {
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    _phoneController.text = _phone;
    _mailController.text = _mail;

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Mettre à jour les informations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      _imagePath != null ? FileImage(File(_imagePath!)) : null,
                  child:
                      _imagePath == null ? const Icon(Icons.camera_alt) : null,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _mailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Téléphone'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _firstName = _firstNameController.text;
                    _lastName = _lastNameController.text;
                    _phone = _phoneController.text;
                    _mail = _mailController.text;
                  });
                  _saveUserData(id, _firstName, _lastName, _mail, _phone);
                  Navigator.pop(context);
                },
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }


 Future<void> _uploadImage() async {
    if (_imagePath == null) return;

    final uri = Uri.parse('YOUR_UPLOAD_API_ENDPOINT'); // Replace with your API endpoint
    final request = http.MultipartRequest('POST', uri)
      ..fields['description'] = 'Image uploaded from Flutter' // Example field
      ..files.add(await http.MultipartFile.fromPath(
        'image', // Field name for the image on your server
        _imagePath!,
        filename: _imagePath,
      ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Image uploaded successfully! Response: $responseBody');
        // Handle success, e.g., display a success message or the image URL
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        // Handle error
      }
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mes informations personelles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _imagePath != null ? FileImage(File(_imagePath!)) : null,
                child: _imagePath == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Nom Prenom"),
              subtitle: Text("$_firstName $_lastName"),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Téléphone"),
              subtitle: Text(_phone),
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text("Email"),
              subtitle: Text(_mail),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openEditModal,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
