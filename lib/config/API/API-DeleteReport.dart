import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiDelete {
  static const String baseUrl =
      'https://api-arutmin.up.railway.app/reports/soft-delete/';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> deleteReport(String reportId) async {
    final String token = await getToken() ?? '';
    final String url = '$baseUrl$reportId'; // Menambahkan ID laporan ke URL
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Data berhasil dihapus');
      } else {
        print('Gagal menghapus data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
