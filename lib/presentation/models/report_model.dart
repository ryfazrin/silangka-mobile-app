import 'package:silangka/presentation/models/animals_model.dart';

class Report {
  final int id;
  final String userId;
  final String title;
  final Animal animal;
  final String imageUrl;
  final String location;
  final int animalCount;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;

  Report({
    required this.id,
    required this.userId,
    required this.title,
    required this.animal,
    required this.imageUrl,
    required this.location,
    required this.animalCount,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      userId: json['userId'] as String,
      title: json['title'] as String,
      animal: Animal.fromJson(json['animal']),
      imageUrl: json['imageUrl'] as String,
      location: json['location'] as String,
      animalCount: json['animalCount'] as int,
      desc: json['desc'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : DateTime.now(),
    );
  }
}

// class Animal {
//   final String name;

//   Animal({required this.name});
//   String getName() {
//     return name;
//   }

//   factory Animal.fromJson(Map<String, dynamic> json) {
//     return Animal(
//       name: json['name'] as String,
//     );
//   }
// }
