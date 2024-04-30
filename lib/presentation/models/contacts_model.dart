class Contact {
  final String logo;
  final String text;

  Contact({required this.logo, required this.text});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      logo: json['logo'],
      text: json['text'],
    );
  }
}