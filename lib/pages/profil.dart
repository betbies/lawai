import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: const Center(
        child: Text(
          'Profil sayfası içeriği buraya gelecek',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
