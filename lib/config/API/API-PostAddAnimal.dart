import 'dart:convert';
import 'package:http/http.dart' as http;

class AddAnimal {
  Future<dynamic> handleReport(String image, String title, String location,
      int animalCount, String desc, int? animalId) async {
    print('image: ${image}');
    print('title: ${title}');
    print('location: ${location}');
    print('animalCount: ${animalCount}');
    print('desc: ${desc}');
    print('id: ${animalId}');
    // try {
    //   var response = await http.post(
    //       Uri.parse('https://api-arutmin.up.railway.app/reports/add-report'),
    //       body: jsonEncode({
    //         'image': image,
    //         'title': title,
    //         'location': location,
    //         'animalCount': animalCount,
    //         'desc': desc,
    //         'id': animalId,
    //       }),
    //       headers: {'Content-Type': 'application/json'});
    //   if (response.statusCode == 200) {
    //     print('Response status: ${response.statusCode}');
    //     print('Response body: ${response.body}');
    //   } else {
    //     print('Failed to load user Data. Status code ${response.statusCode}');
    //     final error = jsonDecode(response.body);
    //     throw Exception(error['message']);
    //   }
    // } catch (error) {
    //   print('Error: $error');
    //   rethrow;
    // }
  }
}
