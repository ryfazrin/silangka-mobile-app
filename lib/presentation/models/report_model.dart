class Report {
  final int id;
  final String userId;
  final String title;
  final AnimalReport animal;
  final String imageUrl;
  final String location;
  final int animalCount;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt; // nullable DateTime
  final String? status;
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
    this.deletedAt, // nullable parameter
    this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      userId: json['userId'] as String,
      title: json['title'] as String,
      animal: AnimalReport.fromJson(json['animal'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String? ?? '',
      location: json['location'] as String? ?? '',
      animalCount: json['animalCount'] as int,
      desc: json['desc'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      status: json['status'] as String? ?? '',
    );
  }
}
class AnimalReport {
  final String name;

  AnimalReport({required this.name});

  factory AnimalReport.fromJson(Map<String, dynamic> json) {
    return AnimalReport(
      name: json['name'] as String,
    );
  }
}
