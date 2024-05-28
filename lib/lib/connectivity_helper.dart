import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();
  late BuildContext context;
  bool _isOffline = false;

  ConnectivityHelper(this.context);

  void initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      handleConnectivityChange(result);
    } catch (e) {
      print("Couldn't check connectivity status: $e");
      return;
    }

    _connectivity.onConnectivityChanged.listen(handleConnectivityChange);
  }

  void handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      if (!_isOffline) {
        _isOffline = true;
        showNoInternetDialog();
      }
    } else {
      if (_isOffline) {
        _isOffline = false;
      }
    }
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
          title: const Text(
            'Tidak Ada Koneksi Internet',
            style: TextStyle(
              color: Color(0xFF58A356),
            ),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda tidak terhubung dengan internet.'),
                Text('Silakan cek koneksi anda dan coba lagi.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (_isOffline) {
                  initConnectivity(); // Recheck connectivity
                }
              },
            ),
          ],
        );
      },
    );
  }
}
