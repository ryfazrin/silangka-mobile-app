import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/contacts.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:silangka/presentation/pages/animal_detail_page.dart';
import 'package:silangka/presentation/pages/report_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Map<String, String>> _animals = [];
  String? _token;
  int _selectedIndex = 0;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void _logout() async {
    await _removeToken();
    Navigator.pushReplacementNamed(context, '/welcome');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool canPop = true;

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Hewan Dilidungi',
            style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
              color: Color(0xFFF8ED8E),
            ),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showDialogLogout(),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          child: SizedBox(
            height: 58,
            child: BottomNavigationBar(
              backgroundColor: Colors.green,
              selectedItemColor: const Color(0xFFF8ED8E),
              onTap: (index) {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportPage(),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportPage(),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactsPage(),
                    ),
                  );
                }
              },
              currentIndex: _selectedIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note_add),
                  label: 'Lapor',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'Hubungi Kami',
                )
              ],
            ),
          ),
        ),
        body: FutureBuilder<List<Animal>>(
          future: ApiAnimal.fetchAnimals(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final animals = snapshot.data!;
              return ListView.builder(
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  final animal = animals[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 345,
                          ),
                          child: Container(
                            width: 345,
                            decoration: BoxDecoration(
                                color: const Color(0xFF58A356),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ]),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AnimalDetailPage(animal: animal),
                                  ),
                                );
                              },
                              title: Text(
                                animal.name,
                                style: const TextStyle(
                                  fontFamily: 'Nexa',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF8ED8E),
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                animal.latinName,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF8ED8E),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDialogLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Color(0xFF58A356),
            ),
          ),
          content: const SingleChildScrollView(
            child: Text('Apakah Anda yakin ingin logout?'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Tidak',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                _logout();
              },
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        );
      },
    );
  }
}
