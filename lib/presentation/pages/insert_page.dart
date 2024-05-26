import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:silangka/config/API/API-PostAddAnimal.dart';
import 'package:silangka/presentation/models/animals_model.dart';
import 'package:silangka/presentation/pages/home_page.dart';
import 'package:silangka/presentation/pages/report_page.dart';
import 'package:silangka/lib/database_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:silangka/config/API/API-GetAnimalsandImage.dart';

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
  bool isOnline = true;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    fetchCategories();
    _getCurrentPosition();
    _checkConnectivity();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          isOnline = result != ConnectivityResult.none;
        });
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (mounted) {
      setState(() {
        isOnline = connectivityResult != ConnectivityResult.none;
      });
    }
  }

  File? image;
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() => this.image = imageTemp);
      }
    } on PlatformException catch (e) {
      print('Gagal memuat gambar');
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() => this.image = imageTemp);
      }
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
      if (mounted) {
        setState(() {
          categories = animalCategories;
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

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

  void _loadCategories() async {
    final dbHelper = DatabaseHelper();
    final categoriesFromDb = await dbHelper.getCategories();
    if (mounted) {
      setState(() {
        categories = categoriesFromDb;
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _lokasiController.text =
          '${_currentPosition!.latitude},${_currentPosition!.longitude}';
        });
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF58A356),
          ),
        ),
        title: const Text(
          'Masukan Laporan',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
            color: Color(0xFFF8ED8E),
          ),
        ),
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
                          child: Text(
                            isOnline ? 'Kirim' : 'Kirim ke Draft',
                            style: const TextStyle(
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

  void _handleSendReport() async {
    if (formKey.currentState!.validate()) {
      if (image != null) {
        final connectivity = await Connectivity().checkConnectivity();
        //ketika perangkat offline
        if (connectivity == ConnectivityResult.none) {
          await _saveDraftReport();
          _showDialogSuccessSendtoDraft();
          return;
        }
        //ketika perangkat online
        try {
          DateTime now = DateTime.now().toUtc();
          String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
          await AddAnimal().handleReport(
            image!,
            _judulLaporanController.text,
            _lokasiController.text,
            int.parse(_jumlahHewanController.text),
            _informasiLainlain.text,
            selectedCategoryId,
            formattedDate,
          );
          _showDialogSuccessSend();
          // Navigator.pushNamed(
          //   context,
          //   HomePage.routeName,
          //   arguments: 1,
          // );
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

  Future<void> _saveDraftReport() async {
    final databaseHelper = DatabaseHelper();
    DateTime now = DateTime.now().toUtc();
    String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);
    print('debug:$formattedDate');
    final report = {
      'title': _judulLaporanController.text,
      'location': _lokasiController.text,
      'animalCount': _jumlahHewanController.text,
      'image': image?.path,
      'categoryId': selectedCategoryId,
      'desc': _informasiLainlain.text,
      'status': 'Draft',
      'createdAt':formattedDate,
    };
    await databaseHelper.insert(report);
  }

  Future<void> _showDialogSuccessSendtoDraft() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
          title: const Text(
            'Sukses',
            style: TextStyle(
              color: Color(0xFF58A356),
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Data Berhasil Dikirim di Draft.',
                  style: TextStyle(color: Color(0xFF58A356)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  HomePage.routeName,
                  arguments: 1,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogSuccessSend() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
          title: const Text(
            'Sukses',
            style: TextStyle(
              color: Color(0xFF58A356),
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Data Berhasil Dikirim.',
                  style: TextStyle(color: Color(0xFF58A356)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  HomePage.routeName,
                  arguments: 1,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
