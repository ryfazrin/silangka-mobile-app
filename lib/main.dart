import 'package:flutter/material.dart';
import 'package:silangka/config/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/home_page.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final isLoggedIn = sharedPreferences.getString('token') != null;

  if (isLoggedIn) {
    runApp(MyApp(
      sharedPreferences: sharedPreferences,
      initialRoute: HomePage.routeName,
    ));
  } else {
    runApp(MyApp(
      sharedPreferences: sharedPreferences,
      initialRoute: WelcomePage.routeName,
    ));
  }
}
