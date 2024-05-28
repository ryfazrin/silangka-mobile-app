import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa status layanan lokasi dan izin
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      // Jika layanan lokasi tidak aktif, tampilkan dialog
      await _showDialogOpenLocationSettings(context);
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    // Periksa status izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Jika izin masih ditolak, tampilkan pesan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Jika izin ditolak selamanya, tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }

    // Jika izin diberikan dan layanan aktif
    return true;
  }

  Future<void> _showDialogOpenLocationSettings(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lokasi Tidak Aktif'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Layanan lokasi tidak aktif. Silakan aktifkan lokasi.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
