class Report {
  final int id;
  final int? idBE;
  final String userId;
  final String title;
  final AnimalReport animal;
  final String imageUrl;
  final String location;
  final int animalCount;
  final String desc;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt; // nullable DateTime
  final String? status;
  Report({
    required this.id,
    this.idBE,
    required this.userId,
    required this.title,
    required this.animal,
    required this.imageUrl,
    required this.location,
    required this.animalCount,
    required this.desc,
     this.createdAt,
     this.updatedAt,
    this.deletedAt, // nullable parameter
    this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      idBE:  json['idBE'] as int? ?? 0,
      userId: json['userId'] as String,
      title: json['title'] as String,
      animal: AnimalReport.fromJson(json['animal'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String? ?? '',
      location: json['location'] as String? ?? '',
      animalCount: json['animalCount'] as int,
      desc: json['desc'] as String? ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      // status: json['status'] as String? ?? '',
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
