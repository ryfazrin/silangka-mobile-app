class Contact {
  final String address;
  final String phone;
  final String fax;
  final String email;
  final String instagram;
  final String facebook;

  Contact({
    required this.address,
    required this.phone,
    required this.fax,
    required this.email,
    required this.instagram,
    required this.facebook,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      fax: json['fax'] ?? '',
      email: json['email'] ?? '',
      instagram: json['instagram'] ?? '',
      facebook: json['facebook'] ?? '',
    );
  }
}
