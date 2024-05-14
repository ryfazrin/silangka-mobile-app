import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/models/contacts_model.dart';

class ApiContacts {
  static const String _baseUrl = 'https://api-arutmin.up.railway.app';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Contact> fetchContact() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/contacts'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final contact = Contact.fromJson(data['data']);
      print('Contact data:');
      print('Address: ${contact.address}');
      print('Phone: ${contact.phone}');
      print('Fax: ${contact.fax}');
      print('Email: ${contact.email}');
      print('Instagram: ${contact.instagram}');
      print('Facebook: ${contact.facebook}');
      return contact;
    } else {
      if (response.statusCode == 401) {
        throw Exception(
            'Autentikasi gagal. Token kedaluwarsa atau tidak valid.');
      } else if (response.statusCode == 404) {
        throw Exception('Kontak tidak ditemukan.');
      } else {
        throw Exception(
            'Gagal memuat kontak. Kode status: ${response.statusCode}');
      }
    }
  }
}
