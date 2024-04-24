import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';
import 'package:silangka/presentation/pages/login_page.dart';
import 'package:silangka/presentation/pages/register_page.dart';
import 'package:silangka/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'SiLangka',
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
