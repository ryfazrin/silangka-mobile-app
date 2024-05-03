import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:silangka/config/API/API-GetContacts.dart';
import 'package:silangka/presentation/models/contacts_model.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);
  static const String routeName = '/contacts';

  @override
  _ContactsPage createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  final _apiContacts = ApiContacts();
  Contact? _contact;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final contact = await _apiContacts.fetchContact();
      setState(() {
        _contact = contact;
        _isLoading = false;
        print('Contact data: $_contact');
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      print('Error fetching contacts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4F3C4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD4F3C4),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Hubungi Kami',
                style: TextStyle(
                  fontFamily: 'Nexa',
                  color: Color(0xFF58A356),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 85),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _contact != null
                      ? Card(
                          color: const Color(0xFF58A356),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            width: 346,
                            height: 288,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Fax: ${_contact!.fax}'),
                                  Text('Phone: ${_contact!.phone}'),
                                  Text('Email: ${_contact!.email}'),
                                  Text('Instagram: ${_contact!.instagram}'),
                                  Text('Facebook: ${_contact!.facebook}'),
                                  Text('Address: ${_contact!.address}'),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Text('Tidak ada data kontak'),
            ],
          ),
        ),
      ),
    );
  }
}
