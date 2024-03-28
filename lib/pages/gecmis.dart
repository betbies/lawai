import 'package:flutter/material.dart';

class GecmisPage extends StatelessWidget {
  const GecmisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Geçmiş Sohbetler',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView.builder(
          itemCount: gecmisSohbetler.length,
          itemBuilder: (context, index) {
            final sohbet = gecmisSohbetler[index];
            final gradientColors = [
              const Color(0xFF88B4BE), // ilk renk
              const Color(0xFF056C89), // ikinci renk
            ];
            return GestureDetector(
              onTap: () {
                _showPopup(context, sohbet);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sohbet,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
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

List<String> gecmisSohbetler = [
  'Geçmiş Sohbet 1',
  'Geçmiş Sohbet 2',
  'Geçmiş Sohbet 3',
  'Geçmiş Sohbet 4',
  'Geçmiş Sohbet 5',
  'Geçmiş Sohbet 6',
  'Geçmiş Sohbet 7',
  'Geçmiş Sohbet 8',
  'Geçmiş Sohbet 9',
  'Geçmiş Sohbet 10',
];
