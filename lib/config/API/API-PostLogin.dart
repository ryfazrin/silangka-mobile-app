import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<dynamic> handleLogin(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('https://api-arutmin.up.railway.app/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        //save token
        final token = jsonDecode(response.body)['token'];
        await _saveTokenToLocalStorage(token);

        return jsonDecode(response.body);
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<void> _saveTokenToLocalStorage(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Token saved to local storage');
  }
}
