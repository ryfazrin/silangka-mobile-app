import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:silangka/lib/connectivity_helper.dart';
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
  late ConnectivityHelper _connectivityHelper;

  @override
  void initState() {
    super.initState();
    _connectivityHelper = ConnectivityHelper(context);
    _connectivityHelper.initConnectivity();
  }

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/warik-with-kabut.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 160,
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
                                    ..color = Color(0xFF58A356),
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
                                // color: Color(0xFF58A356),
                                color: Colors.white,
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
                                    ..color = Color(0xFF58A356),
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
                                // color: Color(0xFF58A356),
                                color: Colors.white,
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
                                    ..color = Color(0xFF58A356),
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
                                // color: Color(0xFF58A356),
                                  color: Colors.white,
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
                                    ..color = Color(0xFF58A356),
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
                                // color: Color(0xFF58A356),
                                  color: Colors.white,
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
                                    ..color = Color(0xFF58A356),
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
                                // color: Color(0xFF58A356),
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(Size(130, 54)),
                            // backgroundColor: MaterialStateProperty.all(Color(0xFF58A356)),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFFFFFFFF),
                              color: Color(0xFF58A356),
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
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(Size(130, 54)),
                            // backgroundColor:
                            //     MaterialStateProperty.all(Color(0xFF58A356)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              // color: Color(0xFFFFFFFF),
                              color: Color(0xFF58A356),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
