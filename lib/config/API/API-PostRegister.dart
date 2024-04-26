import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRegister {
  Future<bool> checkWhatsAppNumberAvailability(String whatsAppNumber) async {
    final url = Uri.parse('https://api-arutmin.up.railway.app/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'whatsAppNumber': whatsAppNumber}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['available'];
    } else {
      throw Exception('Failed to check WhatsApp number availability');
    }
  }

  Future<bool> checkEmailAvailability(String email) async {
    final url = Uri.parse('https://api-arutmin.up.railway.app/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['available'];
    } else {
      throw Exception('Failed to check email availability');
    }
  }

  Future<void> handleRegister(
    String fullName,
    String email,
    String noHp,
    String password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print(jsonEncode({
        'fullName': fullName,
        'email': email,
        'noHp': noHp,
        'password': password,
      }));
      var response = await http.post(
        Uri.parse('https://api-arutmin.up.railway.app/users/register'),
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'noHp': noHp,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // If the registration is successful, save the user data locally
        await prefs.setString('user', response.body);
        print('Registration successful.');
      } else {
        // Handle different response codes accordingly
        print('Failed to register user. Status code: ${response.statusCode}');
        final error = jsonDecode(response.body);
        throw Exception(error['message']);
        // throw Exception('Failed to register user');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
