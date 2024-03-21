import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://example.com/your-profile-picture.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kullanıcı Adı',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'email@example.com',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: const Text('Düzenle'),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Adı Soyadı'),
              subtitle: Text('Kullanıcının adı soyadı burada görünecek'),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('E-posta'),
              subtitle: Text('email@example.com'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Telefon'),
              subtitle: Text('+90 123 456 7890'),
            ),
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Ödeme Yöntemi'),
              subtitle: Text('Kredi Kartı'),
            ),
          ],
        ),
      ),
    );
  }
}
