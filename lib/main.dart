import 'package:flutter/material.dart';
import 'member/login.dart';
import 'pages/gecmis.dart';
import 'pages/kesfet.dart';
import 'pages/profil.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 1, // Keşfet sayfasının index'i 1 olduğu için varsayılan olarak buradan başlayacak
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  GecmisPage(),
                  KesfetPage(),
                  ProfilPage(),
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat), text: 'Geçmiş'),
                Tab(icon: Icon(Icons.explore), text: 'Keşfet'),
                Tab(icon: Icon(Icons.person), text: 'Profil'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
