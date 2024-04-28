import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  _HomePage createState() => _HomePage();
}

// @override
// Future<bool> willPopScope() async {
//   SystemNavigator.pop();
//   return false;
// }

class _HomePage extends State<HomePage> {
  // String? _token;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadToken();
  // }

  // Future<void> _loadToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _token = prefs.getString('token');
  //   });
  // }

  // Future<void> _saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }

  // Future<void> _removeToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  // }

  // void _logout() async {
  //   await _removeToken();
  //   Navigator.pushReplacementNamed(context, '/login');
  // }

  // Future<void> _showDialog() async {
  //   final bool? shouldDiscard = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Apakah Anda yakin keluar?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //             child: const Text('Batal'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(true);
  //             },
  //             child: const Text('Keluar'),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (shouldDiscard == true) {
  //     SystemNavigator.pop();
  //   }
  // }
  bool canPop = true;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        print('onPopInvoked is trigered');
        if (didPop) {
          print('Pop operation was successful');
        } else {
          print('Pop operation failed');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Hewan Dilidungi',
            style: TextStyle(
              fontFamily: 'Nexa',
              fontWeight: FontWeight.bold,
              color: Color(0xFF58A356),
            ),
          ),
          backgroundColor: Color(0xFFD4F3C4),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.logout),
          //     onPressed: () => _logout(),
          //   ),
          // ],
        ),
      ),
    );
  }
}
