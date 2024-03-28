import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Kullanıcı Adı');
  final TextEditingController _emailController = TextEditingController(text: 'email@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '+90 123 456 7890');

  final TextEditingController _tempNameController = TextEditingController();
  final TextEditingController _tempEmailController = TextEditingController();
  final TextEditingController _tempPhoneController = TextEditingController();

  File? _image;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _tempNameController.text = _nameController.text;
    _tempEmailController.text = _emailController.text;
    _tempPhoneController.text = _phoneController.text;

    _loadImageFromPrefs();
  }

  _loadImageFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String? imagePath = _prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  _saveImageToPrefs(String imagePath) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('profile_image', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/LAWW1.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.white.withOpacity(0.6),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showImagePickerDialog();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _nameController.text,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _emailController.text,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showEditDialog();
                    },
                    child: const Text(
                      'Düzenle',
                      style: TextStyle(color: Color(0xFF023653)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Adı Soyadı'),
                    subtitle: Text(_nameController.text),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('E-posta'),
                    subtitle: Text(_emailController.text),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Telefon'),
                    subtitle: Text(_phoneController.text),
                  ),
                  const ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Ödeme Yöntemi'),
                    subtitle: Text('Kredi Kartı'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showEditDialog() async {
    _tempNameController.text = _nameController.text;
    _tempEmailController.text = _emailController.text;
    _tempPhoneController.text = _phoneController.text;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bilgileri Düzenle"),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                _buildTextField(_tempNameController, 'Adı Soyadı'),
                _buildTextField(_tempEmailController, 'E-posta'),
                _buildTextField(_tempPhoneController, 'Telefon'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text(
                'Kaydet',
                style: TextStyle(color: Color(0xFF023653)),
              ),
              onPressed: () {
                if (!_isValidEmail(_tempEmailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Geçerli bir e-posta adresi girin')),
                  );
                  return;
                }

                if (!_isValidPhone(_tempPhoneController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Geçerli bir telefon numarası girin')),
                  );
                  return;
                }

                setState(() {
                  _nameController.text = _tempNameController.text;
                  _emailController.text = _tempEmailController.text;
                  _phoneController.text = _tempPhoneController.text;
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text(
                'İptal',
                style: TextStyle(color: Color(0xFF023653)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Profil Resmini Değiştir"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Galeriden Seç"),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 600,
    );

    if (pickedFile != null) {
      _saveImageToPrefs(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final RegExp regex = RegExp(r"^\+?90\s?\d{3}\s?\d{3}\s?\d{2}\s?\d{2}$");
    return regex.hasMatch(phone);
  }
}
