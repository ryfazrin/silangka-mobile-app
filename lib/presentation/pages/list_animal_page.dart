import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:silangka/presentation/pages/animal_detail_page.dart';
import 'package:silangka/config/config.dart';

class ListAnimalPage extends StatefulWidget {
  const ListAnimalPage({super.key});

  @override
  State<ListAnimalPage> createState() => _ListAnimalPageState();
}

class _ListAnimalPageState extends State<ListAnimalPage> {
  final String baseUrl = Config.baseUrl;
  Future<List<Animal>>? _futureAnimals;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _futureAnimals = ApiAnimal.fetchAnimals();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _refreshAnimals() async {
    await _checkConnectivity();
    if (_isConnected) {
      setState(() {
        _futureAnimals = ApiAnimal.fetchAnimals();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Animal>>(
      future: _futureAnimals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return _isConnected
              ? Center(
                  child: Text('${snapshot.error}'),
                )
              : _buildNoConnectionMessage();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No animals found.'),
          );
        } else {
          final animals = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshAnimals,
            child: ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 345,
                    ),
                    child: Container(
                      width: 345,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFF58A356)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
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
                            '$baseUrl/animals/images/${animal.imageUrl}',
                            width: 80,
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
                            color: Color(0xFF58A356),
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          animal.latinName,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF58A356),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildNoConnectionMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Internet disconnected',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _refreshAnimals,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              fixedSize: MaterialStateProperty.all(const Size(130, 54)),
              // backgroundColor:
              //     MaterialStateProperty.all(Color(0xFF58A356)),
            ),
            child: const Text(
              'Refresh',
              style: TextStyle(
                fontFamily: 'Nexa',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                // color: Color(0xFFFFFFFF),
                color: Color(0xFF58A356),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
