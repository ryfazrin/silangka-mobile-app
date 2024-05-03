import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:silangka/presentation/pages/login_page.dart';
import 'package:silangka/presentation/pages/register_page.dart';
import 'package:flutter/services.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static const String routeName = '/welcome';
  @override
  _WelcomePage createState() => _WelcomePage();
}

bool canPop = true;

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (didPop) {
          print('Swipe back detected, closing the app...');
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 220),
                          child: Container(
                            width: 400,
                            height: 550,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/hewan-removebg-preview.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/images/image-removebg-preview.png',
                            width: 100,
                            height: 77,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/images/Logo Arutmin Black.png',
                            width: 100,
                            height: 77,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 510,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'Pelaporan satwa mudah',
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(2, 3),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Pelaporan satwa mudah',
                                  style: TextStyle(
                                    color: Color(0xFF58A356),
                                    fontSize: 20,
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'dengan',
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(2, 3),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'dengan',
                                  style: TextStyle(
                                    color: Color(0xFF58A356),
                                    fontSize: 20,
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'SILANGKA',
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'SILANGKA',
                                  style: TextStyle(
                                      color: Color(0xFF58A356),
                                      fontSize: 45,
                                      fontFamily: 'Nexa',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'Sistem Informasi',
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Sistem Informasi',
                                  style: TextStyle(
                                      color: Color(0xFF58A356),
                                      fontSize: 16,
                                      fontFamily: 'Nexa',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    'Laporan Satwa Langka',
                                    style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(2, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Laporan Satwa Langka',
                                  style: TextStyle(
                                    color: Color(0xFF58A356),
                                    fontSize: 16,
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(Size(130, 54)),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF58A356)),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(Size(130, 54)),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF58A356)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
