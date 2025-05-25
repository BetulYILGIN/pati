import 'package:flutter/material.dart';
import 'package:pati_check/db/database_helper.dart'; // Corrected import path
import 'package:crypto/crypto.dart';
// import 'package:pati_check/screens/home_page.dart'; // Removed home_page.dart import
import 'package:pati_check/screens/patitagram_page.dart'; // Added patitagram_page.dart import
import 'dart:convert'; // for utf8
// Note: account_type_page.dart import is not present in this file, which is fine as it's not used here.

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async { // Made async
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic>? user = await dbHelper.getUserByEmail(email);

      // Genel if (!mounted) return; kaldırıldı.

      if (user == null) {
        if (!mounted) return; // Spesifik kontrol
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Geçersiz e-posta veya şifre.')),
        );
      } else {
        // Hash the entered password
        var bytes = utf8.encode(password); // data being hashed
        var digest = sha256.convert(bytes);
        String hashedPassword = digest.toString();

        // if (!mounted) return; // Buraya da eklenebilir ama yukarıdaki daha genel.
        // Özellikle async olmayan crypto işlemi sonrası değil, context kullanan işlemlerden önce olmalı.
        // Bu yüzden aşağıdaki if bloğundan önce olması daha mantıklı.

        if (user['password'] != hashedPassword) {
          if (!mounted) return; // Spesifik kontrol (ScaffoldMessenger öncesi)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Geçersiz e-posta veya şifre.')),
          );
        } else {
          if (!mounted) return; // Spesifik kontrol (ScaffoldMessenger için)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Giriş başarılı! Hoş geldiniz ${user['email']}.')), // user['email'] kullanımı Map<String, dynamic> için doğru
          );
          // Navigator.pushReplacement( // ESKİ YANLIŞ KULLANIM
          //   context,
          //   MaterialPageRoute(builder: (context) => const HomeScreen()),
          // );
          if (!mounted) return; // Navigator için ek kontrol
          Navigator.pushReplacementNamed(context, '/patitagram'); // YENİ DOĞRU KULLANIM
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pati Giriş'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-posta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen e-postanızı girin';
                  }
                  if (!value.contains('@')) {
                    return 'Geçerli bir e-posta girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Giriş Yap'),
              ),
              const SizedBox(height: 16), // Added space between buttons
              ElevatedButton(
                onPressed: () async {
                  DatabaseHelper dbHelper = DatabaseHelper();
                  Map<String, dynamic> user = {
                    'email': 'test@example.com',
                    // Hash the password before inserting
                    'password': sha256.convert(utf8.encode('password123')).toString(),
                  };
                  try {
                    await dbHelper.insertUser(user);
                    // Genel if (!mounted) return; kaldırıldı.
                    if (!mounted) return; // Spesifik kontrol
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kullanıcı test@example.com eklendi.')),
                    );
                  } catch (e) {
                    // Genel if (!mounted) return; kaldırıldı.
                    // Check if the error is due to a unique constraint violation
                    if (e.toString().contains('UNIQUE constraint failed')) {
                      if (!mounted) return; // Spesifik kontrol
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Kullanıcı test@example.com zaten mevcut.')),
                      );
                    } else {
                      if (!mounted) return; // Spesifik kontrol
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kullanıcı eklenirken hata oluştu: $e')),
                      );
                    }
                  }
                },
                child: const Text('Örnek Kullanıcı Oluştur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
