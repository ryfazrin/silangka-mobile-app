import 'package:flutter/material.dart';
import 'package:silangka/presentation/models/animals_model.dart';

class AnimalDetailPage extends StatelessWidget {
  final Animal animal;

  const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(animal.imageUrl),
              Image.network(
                  'https://api-arutmin.up.railway.app/animals/images/${animal.imageUrl}'),
              const SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  children: [
                    TextSpan(text: 'Nama Latin: '),
                    TextSpan(
                        text: animal.latinName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Distribusi: ${animal.distribution}'),
              const SizedBox(height: 16.0),
              Text('Karakteristik: ${animal.characteristics}'),
              const SizedBox(height: 16.0),
              Text('Habitat: ${animal.habitat}'),
              const SizedBox(height: 16.0),
              Text('Jenis Makanan: ${animal.foodType}'),
              const SizedBox(height: 16.0),
              Text('Perilaku Unik: ${animal.uniqueBehavior}'),
              const SizedBox(height: 16.0),
              Text('Periode Kehamilan: ${animal.gestationPeriod}'),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jumlah Sebaran:'),
                  const SizedBox(height: 8.0),
                  ...animal.estimationAmounts.map((estimationAmount) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Area: ${estimationAmount.area ?? '-'}, Tahun: ${estimationAmount.year ?? '-'}, Total: ${estimationAmount.total ?? '-'}',
                      ),
                    );
                  }).toList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
