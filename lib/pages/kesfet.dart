import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    home: KesfetPage(),
  ));
}

class KesfetPage extends StatefulWidget {
  const KesfetPage({Key? key}) : super(key: key);

  @override
  _KesfetPageState createState() => _KesfetPageState();
}

class _KesfetPageState extends State<KesfetPage> {
  List<Service> services = [
    Service('Medeni Hukuk'),
    Service('Ceza Hukuku'),
    Service('İdare Hukuku'),
    Service('Anayasa Hukuku'),
    Service('Uluslararası Hukuk'),
    Service('Ticaret Hukuku'),
    Service('İş Hukuku'),
    Service('X Hukuku'),
    Service('X Hukuku'),
    Service('X Hukuku'),
  ];

  List<String> popularQuestions = [
    'Boşanma süreci nasıldır?',
    'Trafik cezası nasıl itiraz edilir?',
    'Şirket kurulumu için gerekenler nelerdir?',
    'Ceza indirimi nasıl alınır?',
    'Velayet davası nasıl açılır?',
  ];

  int? selectedServiceIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Hoşgeldiniz',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 22,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Düzenle butonuna tıklandığında yapılacak işlemler
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/LAWW1.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.white.withOpacity(0.5), // Beyaz efekt
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4.0,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedServiceIndex = index;
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
                        child: serviceContainer(services[index].name, index),
                      );
                    },
                  ),
                  const SizedBox(height: 20), // "Hukuk Alanları" yazısı için boşluk
                  const Text(
                    'Popüler Sorular',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...popularQuestions.map((question) {
                    return ListTile(
                      title: Text(
                        question,
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // Burada ChatPage'e yönlendirme yapılıyor.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(allowSendMessage: false),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceContainer(String name, int index) {
    bool isSelected = selectedServiceIndex == index;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle, // Kare kutu
        borderRadius: BorderRadius.circular(40.0), // Köşeleri yuvarlaklaştır
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        border: isSelected
            ? Border.all(
          color: Colors.black,
          width: 4,
        )
            : null,
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Service {
  final String name;

  Service(this.name);
}

class ChatPage extends StatefulWidget {
  final bool allowSendMessage;

  const ChatPage({Key? key, this.allowSendMessage = true}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'message': 'Merhaba 👋🏻 \nLütfen bana merak ettiğiniz bir şeyi sorun', 'isMe': false, 'color': const Color(0xFF056C89)}
  ];
  final bool _isOnline = true;

  String? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImage = prefs.getString('profile_image');
    });
  }

  _saveProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', imagePath);
    setState(() {
      _profileImage = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/LAWW3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Column(
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
                              ? Container()
                              : CircleAvatar(
                            backgroundImage: AssetImage('assets/images/LAWWCON.png'), // Profil resmi
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: _messages[index]['color'],
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
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: _messages[index]['isMe'] ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          _messages[index]['isMe']
                              ? (_profileImage != null
                              ? CircleAvatar(
                            backgroundImage: FileImage(File(_profileImage!)),
                          )
                              : Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.person, color: Colors.white),
                          ))
                              : Container(), // Profil resmi eklendi
                        ],
                      ),
                    );
                  },
                ),
              ),
              if(widget.allowSendMessage)
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
                            color: Colors.white,
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
                              _messages.insert(0, {'message': _textController.text, 'isMe': true, 'color': Colors.white});
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
        ],
      ),
      backgroundColor: const Color(0xFFC3E4E9),
    );
  }
}
