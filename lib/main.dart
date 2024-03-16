import 'package:flutter/material.dart';
import 'member/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1; // Keşfet sekmesine yönlendirecek şekilde değiştirildi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LAW AI'),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Geçmiş',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Keşfet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return Column(
        children: [
          Expanded(
            child: _buildChatMessages(),
          ),
          _buildTextEditor(),
        ],
      );
    } else if (_currentIndex == 1) {
      return Container(); // Keşfet sayfasının içeriği boşaltıldı
    } else {
      return const Center(
        child: Text('Profil içeriği'),
      );
    }
  }

  Widget _buildChatMessages() {
    return ListView(
      children: const [
        ListTile(
          title: Text('Geçmiş Sohbet 1'),
        ),
        ListTile(
          title: Text('Geçmiş Sohbet 2'),
        ),
      ],
    );
  }

  Widget _buildTextEditor() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Mesajınızı buraya yazın...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Mesaj gönderme işlemleri
            },
          ),
        ),
      ),
    );
  }
}
