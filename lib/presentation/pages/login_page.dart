import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:silangka/presentation/pages/register_page.dart';
import 'package:silangka/config/API/API-PostLogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:silangka/presentation/pages/welcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService();

  bool showPassword = false;
  bool emailFocus = false;
  bool passwordFocus = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: Color(0xFFD4F3C4),
      appBar: AppBar(
        backgroundColor: Color(0xFFD4F3C4),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Nexa',
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF58A356),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kembali di SILANGKA, titik pertemuan,',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 14,
                            color: Color(0xFF58A356),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'kepedulian terhadap satwa liar.',
                          style: TextStyle(
                            fontFamily: 'Nexa',
                            fontSize: 14,
                            color: Color(0xFF58A356),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF58A356),
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: emailFocus ? 10 : 5,
                          child: Container(
                            width: 345,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              onTap: () {
                                setState(() {
                                  emailFocus = true;
                                  passwordFocus = false;
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x88888888),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Harap masukkan alamat email yang valid';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  emailFocus = true;
                                  passwordFocus = false;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: [
                              Text(
                                'Password',
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF58A356),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: passwordFocus ? 10 : 5,
                          child: Container(
                            width: 345,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !showPassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                labelStyle: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0x88888888),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _handleLogin();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Silakan isi masukan'),
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
                                  MaterialStateProperty.all(Size(345, 60)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF58A356)),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Nexa',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF58A356),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF074AF5),
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFD4F3C4),
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
                  'Berhasil Login.',
                  style: TextStyle(color: Color(0xFF58A356)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogFailed(String errorMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFD4F3C4),
          title: const Text(
            'Gagal',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Color(0xFF58A356),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        final userData = await _apiService.handleLogin(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Login Berhasil'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        await _showDialogSuccess();
        Navigator.pushReplacementNamed(context, '/homepage');
        print('User data: $userData');
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Gagal Login: $e'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        await _showDialogFailed(e.toString());
        print('Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan isi kolom'),
        ),
      );
    }
  }
}
