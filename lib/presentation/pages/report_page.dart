import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silangka/config/API/API-PostAddAnimal.dart';
import 'package:silangka/presentation/pages/contacts.dart';
import 'package:silangka/presentation/pages/home_page.dart';
import 'package:silangka/presentation/pages/insert_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);
  static const String routeName = '/reportpage';

  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {
  final formKey = GlobalKey<FormState>();
  final _judulLaporanController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _jumlahHewanController = TextEditingController();
  String? selectedCategoryId;

  late XFile? image = null;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Daftar Laporan',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
            color: Color(0xFFF8ED8E),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
        child: SizedBox(
          height: 58,
          child: BottomNavigationBar(
            backgroundColor: Colors.green,
            selectedItemColor: Color(0xFFF8ED8E),
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InsertPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
