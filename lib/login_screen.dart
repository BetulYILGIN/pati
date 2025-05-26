import 'package:flutter/material.dart';
import '../db/database_helper.dart';  // Eğer User modeli ayrı dosyadaysa

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen e-posta ve şifre girin.')),
      );
      return;
    }

    User? user = await dbHelper.loginUser(email, password); // ✅ Değiştirildi

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geçersiz e-posta veya şifre.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı! Hoş geldiniz ${user.email}.')),
      );
      Navigator.pushReplacementNamed(context, '/patitagram');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
