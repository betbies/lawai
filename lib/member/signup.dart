import 'package:flutter/material.dart';
import '../main.dart'; // Ana sayfanın bulunduğu dosyayı doğru şekilde import ettiğinizden emin olun

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Burada kayıt işlemleri yapılabilir

            // Kullanıcı girişi başarılı olursa ana sayfaya yönlendir
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
          child: const Text('Sign Up'),
        ),
      ),
    );
  }
}
