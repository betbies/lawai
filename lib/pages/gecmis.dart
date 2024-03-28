import 'package:flutter/material.dart';

class GecmisPage extends StatelessWidget {
  const GecmisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş Sohbetler'),
        backgroundColor: Colors.white,
        elevation: 0, // App Bar'ın gölgesini kaldırır
        iconTheme: const IconThemeData(color: Colors.black), // Geri butonunun rengini ayarlar
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: gecmisSohbetler.length,
          itemBuilder: (context, index) {
            final sohbet = gecmisSohbetler[index];
            return GestureDetector(
              onTap: () {
                _showPopup(context, sohbet); // Butona tıklandığında popup göstermek için
              },
              child: Card(
                color: const Color(0xFF056C89), // Buton arka plan rengi
                elevation: 2, // Kartın gölgesini ayarlar
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0), // Kartın kenar yuvarlaklığını ayarlar
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    sohbet,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context, String sohbet) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Geçmiş Sohbet'),
        content: Text(sohbet),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Kapat'),
          ),
        ],
      );
    },
  );
}

// Geçmiş sohbetlerin listesi (örnek veri)
List<String> gecmisSohbetler = [
  'Geçmiş Sohbet 1',
  'Geçmiş Sohbet 2',
  'Geçmiş Sohbet 3',
  'Geçmiş Sohbet 4',
  'Geçmiş Sohbet 5',
  // İsterseniz bu listeyi dilediğiniz gibi genişletebilirsiniz
];
