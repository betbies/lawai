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
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

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
            label: 'Chat',
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
              (index) => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Buton tıklama işlemleri
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.blue, width: 3),
                ),
                shadowColor: Colors.black,
                elevation: 5,
              ),
              child: const Text('SORU'),
            ),
          ),
        ),
      );
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
          title: Text('Sohbet Mesajı 1'),
        ),
        ListTile(
          title: Text('Sohbet Mesajı 2'),
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
