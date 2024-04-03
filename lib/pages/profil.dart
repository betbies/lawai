import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfilPage(),
  ));
}

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Kullanıcı Adı');
  final TextEditingController _emailController = TextEditingController(text: 'email@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '+90 123 456 7890');

  File? _image;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
        ],
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
            color: Colors.white.withOpacity(0.5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
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
                          onPressed: _showImagePickerDialog,
                        ),
                      ],
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
    final TextEditingController tempNameController = TextEditingController(text: _nameController.text);
    final TextEditingController tempEmailController = TextEditingController(text: _emailController.text);
    final TextEditingController tempPhoneController = TextEditingController(text: _phoneController.text);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bilgileri Düzenle"),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                _buildTextField(tempNameController, 'Adı Soyadı'),
                _buildTextField(tempEmailController, 'E-posta'),
                _buildTextField(tempPhoneController, 'Telefon'),
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
                if (!_isValidEmail(tempEmailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Geçerli bir e-posta adresi girin')),
                  );
                  return;
                }

                if (!_isValidPhone(tempPhoneController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Geçerli bir telefon numarası girin')),
                  );
                  return;
                }

                setState(() {
                  _nameController.text = tempNameController.text;
                  _emailController.text = tempEmailController.text;
                  _phoneController.text = tempPhoneController.text;
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
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
    );
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final RegExp regex = RegExp(
      r"^\+?90\s?\d{3}\s?\d{3}\s?\d{2}\s?\d{2}$",
    );
    return regex.hasMatch(phone);
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
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Resmi Kaldır"),
                  onTap: () {
                    _removeImage();
                    Navigator.of(context).pop();
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

  _removeImage() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove('profile_image');
    setState(() {
      _image = null;
    });
  }
}

class ChatPage extends StatelessWidget {
  final String profileImagePath;

  const ChatPage({super.key, required this.profileImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: FileImage(File(profileImagePath)),
                  ),
                  title: Text('Kullanıcı Mesajı $index'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Mesajınızı yazın'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Mesajı gönderme işlemi
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
