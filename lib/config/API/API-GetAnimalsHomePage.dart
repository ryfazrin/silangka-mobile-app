import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  final String apiUrl = 'https://api-arutmin.up.railway.app/animals';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
    } else {
      print('Failed to load data. Status code:${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void main() {
  fetchData();
}
