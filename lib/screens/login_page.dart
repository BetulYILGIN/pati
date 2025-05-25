import 'package:flutter/material.dart';
import 'package:pati_check/screens/account_type_page.dart'; // Added import
import 'package:pati_check/db/database_helper.dart'; // Added DatabaseHelper import
import 'package:pati_check/screens/patitagram_page.dart'; // Added PatitagramPage import
// import 'package:pati_check/screens/clinic_main_page.dart'; // Eğer klinik için ayrı bir ana sayfa olacaksa

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async { // Changed to async
    // Using existing _emailController and _passwordController as per analysis
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun!')),
      );
      return;
    }

    // Form validation is good, but the provided snippet doesn't use _formKey.currentState.validate()
    // If form validation is desired, it should be re-added here.
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    DatabaseHelper dbHelper = DatabaseHelper();
    User? user = await dbHelper.loginUser(email, password);

    if (!mounted) return;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı! Hoş geldiniz ${user.email}. Kullanıcı Türü: ${user.userType}')),
      );
      // Kullanıcı türüne göre yönlendirme yapılabilir.
      // Şimdilik tüm başarılı girişleri PatitagramPage'e yönlendirelim.
      // if (user.userType == 'pati') {
      Navigator.pushReplacementNamed(context, '/patitagram');
      // } else if (user.userType == 'klinik') {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const ClinicMainPage()), // Örnek klinik ana sayfası
      //   );
      // }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş bilgileri hatalı veya kullanıcı bulunamadı.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20), // Added space
              GestureDetector(
                onTap: () {
                  if (!mounted) return;
                  Navigator.pushNamed(context, '/account_type');
                },
                child: const Text(
                  'Don\'t have an account? Create one',
                  style: TextStyle(
                    color: Colors.pink, // Example color
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for AccountTypePage to allow code to be structured.
// Removed placeholder AccountTypePage class
