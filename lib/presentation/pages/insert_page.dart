import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:silangka/config/API/API-PostAddAnimal.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:silangka/presentation/pages/report_page.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);
  static const String routeName = '/insertpage';

  @override
  _InsertPage createState() => _InsertPage();
}

class _InsertPage extends State<InsertPage> {
  final formKey = GlobalKey<FormState>();
  final _judulLaporanController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _jumlahHewanController = TextEditingController();
  final _informasiLainlain = TextEditingController();

  int? selectedCategoryId;
  List<Animal> categories = [];
  Position? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _getCurrentPosition();
  }

  File? image;
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Gagal memuat gambar');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Gagal memuat gambar dari kamera');
    }
  }

  void _showPickOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto'),
                onTap: () {
                  pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> fetchCategories() async {
    try {
      final animals = await ApiAnimal.fetchAnimals();
      final List<Animal> animalCategories = animals;
      setState(() {
        print(categories);
        categories = animalCategories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

//teks longtitude dan latitude-nya dihapus, dan latitude sebelah kiri dan longtitude sebalah kanan
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Lokasi tidak diaktifkan, mohon aktifkan')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Izin lokasi ditolak')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Izin lokasi ditolak permanen, mohon aktifkan dari pengaturan')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _lokasiController.text =
            '${_currentPosition!.longitude},${_currentPosition!.latitude}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF58A356),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              image != null
                  ? Image.file(
                      image!,
                      width: 250,
                      height: 250,
                    )
                  : const Text(''),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.green,
                child: const Text(
                  'Upload Gambar',
                  style: TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 12,
                    color: Color(0xFFF8ED8E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _showPickOptions(context);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Judul Laporan',
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF58A356),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: 345,
                          child: TextFormField(
                            controller: _judulLaporanController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: 345,
                          child: DropdownButtonFormField<int>(
                            isExpanded: true,
                            value: selectedCategoryId,
                            onChanged: (int? newValue) {
                              setState(() {
                                selectedCategoryId = newValue;
                              });
                            },
                            items: categories.map((Animal category) {
                              return DropdownMenuItem<int>(
                                value: category.id,
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontFamily: 'Nexa',
                                    fontSize: 14,
                                    color: Color(0xFFF8ED8E),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF58A356),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Pilih Jenis Hewan',
                              hintStyle: const TextStyle(
                                fontFamily: 'Nexa',
                                fontSize: 14,
                                color: Color(0xFFF8ED8E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            dropdownColor: const Color(0xFF58A356),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Lokasi',
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF58A356),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: 345,
                          child: TextFormField(
                            controller: _lokasiController,
                            enabled: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Jumlah Hewan',
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF58A356),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: 345,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _jumlahHewanController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Informasi lain-lain',
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF58A356),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: 345,
                          child: TextFormField(
                            maxLines: 4,
                            controller: _informasiLainlain,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _handleSendReport();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Silakan isi kolom'),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            fixedSize:
                                MaterialStateProperty.all(const Size(345, 60)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF58A356)),
                          ),
                          child: const Text(
                            'Kirim',
                            style: TextStyle(
                              fontFamily: 'Nexa',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
// desc tidak wajib
  void _handleSendReport() async {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        try {
          final reportData = await AddAnimal().handleReport(
            image!,
            _judulLaporanController.text,
            _lokasiController.text,
            int.parse(_jumlahHewanController.text),
            _informasiLainlain.text,
            selectedCategoryId,
          );
          Navigator.pushNamed(
            context,
            ReportPage.routeName,
            arguments: reportData,
          );
        } catch (e) {
          print('Gagal mengirim laporan: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal mengirim laporan: $e'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan pilih gambar terlebih dahulu'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan isi semua kolom'),
        ),
      );
    }
  }
}
