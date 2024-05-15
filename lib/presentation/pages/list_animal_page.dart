import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/contacts.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:silangka/presentation/pages/animal_detail_page.dart';

class ListAnimalPage extends StatefulWidget {
  const ListAnimalPage({super.key});

  @override
  State<ListAnimalPage> createState() => _ListAnimalPageState();
}

class _ListAnimalPageState extends State<ListAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Animal>>(
      future: ApiAnimal.fetchAnimals(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final animals = snapshot.data!;
          return ListView.builder(
            itemCount: animals.length,
            itemBuilder: (context, index) {
              final animal = animals[index];
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 345,
                  ),
                  child: Container(
                    width: 345,
                    decoration: BoxDecoration(
                      // color: Color(0xFF58A356),
                      color: Colors.white,
                      border: Border.all(color: Color(0xFF58A356)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimalDetailPage(animal: animal),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(8), // Border radius 8.0
                        child: Image.network(
                          'https://arutmin-api.up.railway.app/animals/images/${animal.imageUrl}',
                          errorBuilder: (context, error, stackTrace) {
                            // Gambar dari assets sebagai pengganti
                            return Image.asset(
                              'assets/images/image-removebg-preview.png',
                              width: 80,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        animal.name,
                        style: const TextStyle(
                          fontFamily: 'Nexa',
                          fontWeight: FontWeight.bold,
                          // color: Color(0xFF58A356),
                          color: Color(0xFF58A356),
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        animal.latinName,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          // color: Color(0xFF58A356),
                          color: Color(0xFF58A356),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
