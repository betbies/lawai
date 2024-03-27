import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../main.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late ConfettiController _confettiController;
  bool _loginPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    Color mavi1 = Color(int.parse('FF056C89', radix: 16));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewInsets.bottom,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              Image.asset(
                'assets/images/LAWW.png',
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.55),
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: mavi1,
                  borderRadius: BorderRadius.circular(32),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width / sqrt(2) * 1.2,
                    width: MediaQuery.of(context).size.width / sqrt(2) * 1.2,
                    child: Transform.rotate(
                      angle: -pi / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Transform.rotate(
                          angle: pi / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'LAW AI',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                'GİRİŞ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: 250,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    filled: false,
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF000000), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF000000), width: 1.0),
                                    ),
                                    hintText: 'E-mail',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 250,
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  style: const TextStyle(
                                    color: Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    filled: false,
                                    contentPadding: const EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF000000), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF000000), width: 1.0),
                                    ),
                                    hintText: 'Şifre',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  _animationController.forward();
                                  _confettiController.play();
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const MyHomePage(),
                                      ),
                                    );
                                    _animationController.reverse();
                                  });
                                },
                                child: AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _scaleAnimation.value,
                                      child: ClipOval(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.5),
                                                blurRadius: 15,
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            color: const Color(0xFFE0E0E0),
                                            padding: const EdgeInsets.all(20),
                                            child: const Icon(
                                              Icons.balance_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
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
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _loginPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _loginPressed = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SignUpPage()), // SignUpPage'e geçiş
                      );
                    },
                    onTapCancel: () {
                      setState(() {
                        _loginPressed = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: _loginPressed
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(1.0),
                            blurRadius: 60,
                            offset: const Offset(0, 3),
                          ),
                        ]
                            : null,
                      ),
                      child: const Text(
                        'KAYIT OL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Colors.blue, Colors.black, Colors.grey],
                  blastDirection: -pi / 4,
                  particleDrag: 0.05,
                  minimumSize: const Size(5, 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
}