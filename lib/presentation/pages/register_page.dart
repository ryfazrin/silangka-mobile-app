import 'package:flutter/material.dart';
import 'package:silangka/presentation/pages/login_page.dart';
import 'package:silangka/config/API/API-PostRegister.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:silangka/presentation/pages/welcome_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _apiService = ApiRegister();

  bool showPassword = false;
  bool emailFocus = false;
  bool passwordFocus = false;
  bool confirmPasswordFocus = false;
  bool showConfirmPassword = false;
  bool _isEmailAvailable = true;
  bool _isWhatsAppNumberAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4F3C4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Nexa',
                      fontSize: 45,
                      color: Color(0xFF58A356),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF58A356),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: Container(
                          width: 345,
                          child: TextFormField(
                            controller: _fullNameController,
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
                                return 'Nama tidak boleh kosong';
                              }
                              if (value.length > 100) {
                                return 'Nama maksimal 100 huruf';
                              }
                              if (value.length < 3) {
                                return 'Nama lengkap minimal 3 karakter';
                              }
                              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                return 'Nama lengkap hanya boleh terdiri dari huruf dan spasi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF58A356),
                              ),
                            ),
                          ),
                          Card(
                            elevation: emailFocus ? 10 : 5,
                            child: SizedBox(
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
                                    return 'Silakan isi email Anda';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Email Anda tidak valid';
                                  }
                                  if (!_isEmailAvailable) {
                                    return 'Email sudah digunakan';
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
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Whatsapp',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF58A356),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 4,
                                child: SizedBox(
                                  width: 345,
                                  child: TextFormField(
                                    controller: _noHpController,
                                    keyboardType: TextInputType.number,
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
                                        return 'Masukan nomor Whatsapp Anda';
                                      }
                                      if (!RegExp(r'^\+?[0-9]{1,3}[0-9]{10,13}$')
                                          .hasMatch(value)) {
                                        return 'Nomor Whatsapp tidak valid';
                                      }
                                      if (!_isWhatsAppNumberAvailable) {
                                        return 'Nomor Whatsapp sudah digunakan';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF58A356),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: passwordFocus ? 10 : 5,
                                child: SizedBox(
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
                                        return 'Silakan masukkan kata sandi Anda';
                                      }
                                      RegExp passwordRegex = RegExp(r'^.{8,}$');
                                      if (!passwordRegex.hasMatch(value)) {
                                        return 'Password minimal 8 karakter';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF58A356),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: confirmPasswordFocus ? 10 : 5,
                                child: SizedBox(
                                  width: 345,
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: !showConfirmPassword,
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
                                          showConfirmPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showConfirmPassword =
                                                !showConfirmPassword;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Konfirmasi password Anda';
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Password Anda tidak cocok';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _handleRegister();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF58A356),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(343, 60),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 24),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontFamily: 'Nexa',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah punya akun?',
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
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF074AF5),
                        fontFamily: 'Lato',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialogSuccess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFD4F3C4),
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
                  'Berhasil Register.',
                  style: TextStyle(color: Color(0xFF58A356)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
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

  void _handleRegister() async {
    if (formKey.currentState!.validate()) {
      try {
        await _apiService.handleRegister(
          _fullNameController.text.trim(),
          _emailController.text.trim(),
          _noHpController.text.trim(),
          _passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Registrasi Berhasil'),
          backgroundColor: Colors.green,
        ));
        // Assuming successful registration if no exception thrown
        Navigator.pushReplacementNamed(
            context, '/login'); // Navigate to login page on success
      } catch (e) {
        // Handle any errors in registration
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi gagal: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show a snackbar if the form is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan isi semua kolom dengan benar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
