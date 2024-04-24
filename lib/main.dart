import 'package:flutter/material.dart';
import 'package:silangka/config/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MyApp(sharedPreferences: sharedPreferences),
  );
}
