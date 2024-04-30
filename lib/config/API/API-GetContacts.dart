import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:silangka/presentation/models/contacts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiContacts {
  static const String _baseUrl = 'https://api-arutmin.up.railway.app/contacts';
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Contact>> fetchContacts() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    // final response = await http.get(Uri.parse(_baseUrl));
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}