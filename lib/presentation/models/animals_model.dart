class Animal {
  final String name;
  final String latinName;
  final String distribution;
  final String characteristics;
  final String habitat;
  final String foodType;
  final String uniqueBehavior;
  final String gestationPeriod;
  final String imageUrl;
  final List<EstimationAmount> estimationAmounts;

  Animal({
    required this.name,
    required this.latinName,
    required this.distribution,
    required this.characteristics,
    required this.habitat,
    required this.foodType,
    required this.uniqueBehavior,
    required this.gestationPeriod,
    required this.imageUrl,
    required this.estimationAmounts,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      latinName: json['latinName'],
      distribution: json['distribution'],
      characteristics: json['characteristics'],
      habitat: json['habitat'],
      foodType: json['foodType'],
      uniqueBehavior: json['uniqueBehavior'],
      gestationPeriod: json['gestationPeriod'],
      imageUrl: json['imageUrl'],
      estimationAmounts: List<EstimationAmount>.from(
        json['estimationAmounts'].map(
          (x) => EstimationAmount.fromJson(x),
        ),
      ),
    );
  }
}

class EstimationAmount {
  final int id;
  final String? area;
  final String? year;
  final String? total;

  EstimationAmount({
    required this.id,
    this.area,
    this.year,
    this.total,
  });

  factory EstimationAmount.fromJson(Map<String, dynamic> json) {
    return EstimationAmount(
      id: json['id'],
      area: json['area'],
      year: json['year'],
      total: json['total'],
    );
  }
}
