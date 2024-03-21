import 'package:flutter/material.dart';

class KesfetPage extends StatefulWidget {
  const KesfetPage({Key? key}) : super(key: key);

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

  int? selectedServiceIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedServiceIndex = selectedServiceIndex == index ? null : index;
                        });
                        // Eğer seçili hizmete tıklanırsa, chat sayfasını 1 saniye gecikmeli olarak aç
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatPage(),
                            ),
                          );
                        });
                      },
                      child: FadeAnimation(
                        (1.0 + index) / 4,
                        serviceContainer(
                          services[index].icon,
                          services[index].name,
                          index,
                          isSelected: selectedServiceIndex == index,
                        ),
                      ),
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

  Widget serviceContainer(IconData icon, String name, int index, {bool isSelected = false}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/LAWWCON.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 80),
                const SizedBox(height: 20),
                Text(name, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
        if (isSelected) // Siyah çerçeve sadece seçildiğinde görünür
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
            ),
          ),
      ],
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

  const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

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
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text('Chat Sayfası'),
      ),
      backgroundColor: const Color(0xFFC3E4E9),
    );
  }
}
