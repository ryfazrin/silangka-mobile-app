import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/models/report_model.dart';

class GetReport {
  static const String baseUrl = 'https://api-arutmin.up.railway.app/reports';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<List<Report>> fetchReport() async {
    final String token = await getToken() ?? '';
    final String url = '$baseUrl';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // print(jsonData['data']);


      // make sure data report
      print(jsonData['data'].map(
            (x) => Report.fromJson(x),
      ));
      final animals = List<Report>.from(
        jsonData['data'].map(
              (x) => Report.fromJson(x),
        ),
      );
      return animals;
    } else {
      throw Exception('Failed to load animals: ${response.statusCode}');
    }
  }
}
