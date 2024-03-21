import 'package:flutter/material.dart';

class KesfetPage extends StatefulWidget {
  const KesfetPage({super.key});

  @override
  _KesfetPageState createState() => _KesfetPageState();
}

class _KesfetPageState extends State<KesfetPage> {
  List<Service> services = [
    Service('Medeni\nHukuk', Icons.book),
    Service('Ceza\nHukuku', Icons.security),
    Service('İdare\nHukuku', Icons.assignment),
    Service('Anayasa\nHukuku', Icons.archive),
    Service('Uluslararası\nHukuk', Icons.description),
    Service('Ticaret\nHukuku', Icons.fingerprint),
    Service('İş\nHukuku', Icons.business),
    Service('X\nHukuku', Icons.policy),
    Service('X\nHukuku', Icons.verified_user),
    Service('X\nHukuku', Icons.how_to_vote),
  ];

  int? selectedServiceIndex;

  final String profileImage = 'assets/images/profile_image.png';

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
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 60), // Profil resmi ve "Hoşgeldiniz" yazısını biraz aşağı kaydır
                    Row(
                      children: [
                        Icon(Icons.account_circle, size: 60), // Profil ikonu ekleyin
                        SizedBox(width: 10),
                        Text(
                          'Hoşgeldiniz',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Diğer içeriklerden önceki boşluk
                    FadeAnimation(
                      1.2,
                      Text(
                        'Size nasıl yardımcı olabiliriz?',
                        textAlign: TextAlign.center, // Metni ortala
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
          decoration: const BoxDecoration(
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
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Metni kalın olarak biçimlendir
                  textAlign: TextAlign.center, // Metni ortala
                ),
              ],
            ),
          ),
        ),
        if (isSelected)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black87,
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


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'message': 'Merhaba 👋🏻 \nLütfen bana merak ettiğiniz bir şeyi sorun 👍🏻', 'isMe': false}
  ];

  final bool _isOnline = true; // Kullanıcının çevrimiçi durumu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LAW AI',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2.0),
                Text(
                  _isOnline ? 'Online' : 'Offline',
                  style: TextStyle(fontSize: 14.0, color: _isOnline ? Colors.green : Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: _messages[index]['isMe'] ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      _messages[index]['isMe']
                          ? Container() // Kullanıcının mesajı olduğunda profil resmi olmayacak
                          : const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: _messages[index]['isMe'] ? Colors.white : const Color(0xFF056C89), // Kullanıcının mesajı olduğunda arkaplan rengi beyaz olacak
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              _messages[index]['message'],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0), // Yatay boşluk ekleme
                      _messages[index]['isMe']
                          ? const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      )
                          : Container(), // Diğer kişinin mesajı olduğunda profil resmi olmayacak
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        contentPadding: EdgeInsets.all(20.0),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.black,
                  iconSize: 32.0,
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      setState(() {
                        _messages.insert(0, {'message': _textController.text, 'isMe': true});
                        _textController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFC3E4E9),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ChatPage(),
  ));
}
