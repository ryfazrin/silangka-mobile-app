import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  _HomePage createState() => _HomePage();
}

@override
Future<bool> willPopScope() async {
  SystemNavigator.pop();
  return false;
}

void _logout(BuildContext context) {
  Navigator.pushReplacementNamed(context, WelcomePage.routeName);
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hewan Dilidungi',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
            color: Color(0xFF58A356),
          ),
        ),
        backgroundColor: Color(0xFFD4F3C4),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
