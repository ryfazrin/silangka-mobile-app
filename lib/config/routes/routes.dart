import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';
import 'package:silangka/presentation/pages/login_page.dart';
import 'package:silangka/presentation/pages/register_page.dart';
import 'package:silangka/presentation/pages/home_page.dart';
import 'package:silangka/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.sharedPreferences,
    required this.initialRoute,
  }) : super(key: key);

  final SharedPreferences sharedPreferences;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'SiLangka',
      initialRoute: initialRoute,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
