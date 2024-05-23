class Animal {
  final int? id;
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
    required this.id,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latinName': latinName,
      'distribution': distribution,
      'characteristics': characteristics,
      'habitat': habitat,
      'foodType': foodType,
      'uniqueBehavior': uniqueBehavior,
      'gestationPeriod': gestationPeriod,
      'imageUrl': imageUrl,
      'estimationAmounts':
          estimationAmounts.map((amount) => amount.toMap()).toList(),
    };
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      name: json['name'],
      latinName: json['latinName'],
      distribution: json['distribution'],
      characteristics: json['characteristics'],
      habitat: json['habitat'],
      foodType: json['foodType'],
      uniqueBehavior: json['uniqueBehavior'],
      gestationPeriod: json['gestationPeriod'],
      imageUrl: json['imageUrl'],
      estimationAmounts: (json['estimationAmounts'] != null)
          ? List<EstimationAmount>.from(
        json['estimationAmounts'].map((x) => EstimationAmount.fromJson(x)),
      )
          : [],

    );
  }

  // factory Animal.fromMap(Map<String, dynamic> map) {
  //   return Animal(
  //     id: map['id'],
  //     name: map['name'],
  //     latinName: map['latinName'],
  //     distribution: map['distribution'],
  //     characteristics: map['characteristics'],
  //     habitat: map['habitat'],
  //     foodType: map['foodType'],
  //     uniqueBehavior: map['uniqueBehavior'],
  //     gestationPeriod: map['gestationPeriod'],
  //     imageUrl: map['imageUrl'],
  //     estimationAmounts: List<EstimationAmount>.from(
  //       (map['estimationAmounts'] as List<dynamic>)
  //           .map((amount) => EstimationAmount.fromMap(amount)),
  //     ),
  //   );
  // }
}

class EstimationAmount {
  final int? id;
  final String? area;
  final String? year;
  final String? total;

  EstimationAmount({
    required this.id,
    this.area,
    this.year,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
      'year': year,
      'total': total,
    };
  }

  factory EstimationAmount.fromJson(Map<String, dynamic> json) {
    return EstimationAmount(
      id: json['id'],
      area: json['area'],
      year: json['year'],
      total: json['total'],
    );
  }
}
