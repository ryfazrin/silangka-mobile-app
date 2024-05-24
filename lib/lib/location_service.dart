import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  Future<bool> handleLocationPermission(BuildContext context) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Periksa apakah layanan lokasi aktif
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      // Jika tidak aktif, tampilkan dialog untuk mengaktifkan
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    // Periksa status izin lokasi
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Jika izin masih ditolak, tampilkan pesan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }

    if (_permissionGranted == PermissionStatus.deniedForever) {
      // Jika izin ditolak selamanya, tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')),
      );
      return false;
    }

    // Jika izin diberikan dan layanan aktif
    return true;
  }
}
