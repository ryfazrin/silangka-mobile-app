import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:silangka/config/API/API-GetContacts.dart';
import 'dart:convert';
import 'package:silangka/presentation/models/contacts_model.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);
  static const String routeName = '/contacts';

  @override
  _ContactsPage createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  final _apiContacts = ApiContacts();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final contacts = await _apiContacts.fetchContacts();
      setState(() {
        _contacts = contacts;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4F3C4),
      appBar: AppBar(
        backgroundColor: Color(0xFFD4F3C4),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Hubungi Kami',
                style: TextStyle(
                  fontFamily: 'Nexa',
                  color: Color(0xFF58A356),
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 85),
              Card(
                color: Color(0xFF58A356),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 346,
                  height: 288,
                  child: Column(
                    children: [
                      for (var contact in _contacts)
                        ListTile(
                          leading: Image.network(contact.logo),
                          title: Text(contact.text),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}