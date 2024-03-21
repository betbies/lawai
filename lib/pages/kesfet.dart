import 'package:flutter/material.dart';

class KesfetPage extends StatefulWidget {
  const KesfetPage({super.key});

  @override
  _KesfetPageState createState() => _KesfetPageState();
}

class _KesfetPageState extends State<KesfetPage> {
  List<Service> services = [
    Service('Medeni Hukuk', Icons.book),
    Service('Ceza Hukuku', Icons.security),
    Service('İdare Hukuku', Icons.assignment),
    Service('Anayasa Hukuku', Icons.archive),
    Service('Uluslararası Hukuk', Icons.description),
    Service('Ticaret Hukuku', Icons.fingerprint),
    Service('İş Hukuku', Icons.business),
    Service('X Hukuku', Icons.policy),
    Service('X Hukuku', Icons.verified_user),
    Service('X Hukuku', Icons.how_to_vote),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: null, // Floating action button'u kaldırıyoruz
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Sağ ve sola 20 değeri uygulandı
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: FadeAnimation(
                  1.2,
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Text(
                      'Size nasıl yardımcı olabiliriz?',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeAnimation(
                      (1.0 + index) / 4,
                      serviceContainer(services[index].icon, services[index].name, index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceContainer(IconData icon, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index) {
            selectedService = -1;
          } else {
            selectedService = index;
          }
        });

        if (selectedService == index) {
          // Eğer seçili hizmete tıklanırsa, chat sayfasını 1 saniye gecikmeli olarak aç
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const ChatPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, -1.0), // Yukarıdan başlangıç pozisyonu
                      end: Offset.zero, // Yatayda sabit, dikeyde 0'a gelme pozisyonu
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Sağ ve sola 20, üst ve alta 10 değeri uygulandı
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.blue.shade50 : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? const Color(0xFF88B4BE) : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80),
            const SizedBox(height: 20),
            Text(name, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final IconData icon;

  Service(this.name, this.icon);
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: (500 * delay).round()),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0.0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text('Chat Sayfası'),
      ),
      backgroundColor: const Color(0xFFC3E4E9), // Arka plan rengi c3e4e9
    );
  }
}
