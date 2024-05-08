import 'package:flutter/material.dart';
import 'package:silangka/presentation/models/animals_model.dart';

class AnimalDetailPage extends StatelessWidget {
  final Animal animal;

  const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          animal.name,
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
            // color: Color(0xFF58A356),
            color: Color(0xFFF8ED8E),
          ),
        ),
        // backgroundColor: const Color(0xFFD4F3C4),
        backgroundColor: const Color(0xFF58A356),
        foregroundColor:  Color(0xFFF8ED8E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8), // Border radius 8.0
                child: Image.network(
                  'https://api-arutmin.up.railway.app/animals/images/${animal.imageUrl}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nama Hewan          ',
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                    TextSpan(
                      text: ': ${animal.name}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nama Latin              ',
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                    TextSpan(
                      text: ': ${animal.latinName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Distribusi: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.distribution}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Karakteristik: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.characteristics}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Habitat: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.habitat}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Jenis Makanan: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.foodType}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Perilaku Unik: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.uniqueBehavior}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Periode Kehamilan: ',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${animal.gestationPeriod}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9CA356),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (animal.estimationAmounts.isNotEmpty) ...[
                    const Text(
                      'Jumlah Sebaran:',
                      style: TextStyle(
                        fontFamily: 'Nexa',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9CA356),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ...animal.estimationAmounts.map((estimationAmount) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Area: ${estimationAmount.area ?? '-'}, Tahun: ${estimationAmount.year ?? '-'}, Total: ${estimationAmount.total ?? '-'}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9CA356),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
