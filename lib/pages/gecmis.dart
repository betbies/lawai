import 'package:flutter/material.dart';

class GecmisPage extends StatelessWidget {
  const GecmisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LAW AI'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Geçmiş Sohbet 1'),
          ),
          ListTile(
            title: Text('Geçmiş Sohbet 2'),
          ),
        ],
      ),
    );
  }
}
