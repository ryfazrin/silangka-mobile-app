import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/models/animals_model.dart';

class ApiAnimal {
  static const String baseUrl = 'https://arutmin-api.up.railway.app/animals';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<List<Animal>> fetchAnimals() async {
    final String token = await getToken() ?? '';
    final String url = '$baseUrl';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final animals = List<Animal>.from(
        jsonData['data'].map(
          (x) => Animal.fromJson(x),
        ),
      );
      return animals;
    } else {
      throw Exception('Failed to load animals: ${response.statusCode}');
    }
  }
}
