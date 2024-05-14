import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAnimal {
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<dynamic> handleReport(File image, String title, String location,
      int animalCount, String desc, int? animalId) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api-arutmin.up.railway.app/reports/add-report'),
      );
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['title'] = title;
      request.fields['location'] = location;
      request.fields['animalCount'] = animalCount.toString();
      request.fields['desc'] = desc;
      if (animalId != null) {
        request.fields['animalId'] = animalId.toString();
      }

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        print('Failed to load user Data. Status code ${response.statusCode}');
        final error = jsonDecode(response.body);
        throw Exception(error['message']);
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
